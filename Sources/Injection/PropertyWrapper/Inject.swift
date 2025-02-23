//
//  Inject.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI

@propertyWrapper
public final class Inject<Wrapped>: DynamicProperty {
    @Environment(\.self) var environment: EnvironmentValues
    private var injectedEnvironment: EnvironmentValues?
    
    public var wrappedValue: Wrapped {
        didSet {
            update()
        }
    }
    
    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }
    
    public func update() {
        update(with: injectedEnvironment ?? environment)
    }
    
    private func update(with environment: EnvironmentValues) {
        guard let injectable = wrappedValue as? Injectable else {
            return
        }
        injectable.injectEnvironment(environment)
    }
}

// MARK: Inject + Projecting

extension Inject where Wrapped: Projecting {
    @inlinable
    public var projectedValue: Wrapped.ProjectedValue { wrappedValue.projectedValue }
}

// MARK: Inject + AutoClosurePropertyWrapper

extension Inject: AutoClosurePropertyWrapper where Wrapped: AutoClosurePropertyWrapper {
    public typealias WrappedValue = Wrapped.WrappedValue
    
    @inlinable
    public convenience init(wrappedValue thunk: @autoclosure @escaping () -> Wrapped.WrappedValue) {
        self.init(wrappedValue: Wrapped(wrappedValue: thunk()))
    }
}

// MARK: Inject + Injectable
    
extension Inject: Injectable {
    public func injectEnvironment(_ environment: EnvironmentValues) {
        injectedEnvironment = environment
        update(with: environment)
    }
    
    #if DEBUG
    public func mock<MockType>(_ keyPath: WritableKeyPath<EnvironmentValues, MockType>, with value: MockType) -> Self {
        guard let injectable = wrappedValue as? Injectable else {
            return self
        }
        injectable.mock(keyPath, with: value)
        return self
    }
    #endif
}

// MARK: Inject + Equatable

extension Inject: Equatable where Wrapped: Equatable {
    @inlinable
    public static func == (lhs: Inject<Wrapped>, rhs: Inject<Wrapped>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}

// MARK: Inject + Hashable

extension Inject: Hashable where Wrapped: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}

// MARK: Inject + CustomStringConvertible

extension Inject: CustomStringConvertible where Wrapped: CustomStringConvertible {
    @inlinable
    public var description: String {
        wrappedValue.description
    }
}
