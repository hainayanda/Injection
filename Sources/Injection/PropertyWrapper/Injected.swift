//
//  Injected.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI
import Combine

@propertyWrapper
public final class Injected<Value>: Injectable {
    
    private let keyPath: KeyPath<EnvironmentValues, Value>
    
    @Published private var _wrappedValue: Value
    public var wrappedValue: Value { _wrappedValue }
    
    public var projectedValue: AnyPublisher<Value, Never> {
        $_wrappedValue.eraseToAnyPublisher()
    }
    
    public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
        self.keyPath = keyPath
        _wrappedValue = EnvironmentValues()[keyPath: keyPath]
    }
    
    public func injectEnvironment(_ environment: EnvironmentValues) {
        _wrappedValue = environment[keyPath: keyPath]
    }
    
    #if DEBUG
    public func mock<MockType>(_ keyPath: WritableKeyPath<EnvironmentValues, MockType>, with value: MockType) -> Self {
        guard keyPath == self.keyPath, let mockValue = value as? Value else {
            return self
        }
        _wrappedValue = mockValue
        return self
    }
    #endif
}

// MARK: Injected + Equatable

extension Injected: Equatable where Value: Equatable {
    @inlinable
    public static func == (lhs: Injected<Value>, rhs: Injected<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}

// MARK: Injected + Hashable

extension Injected: Hashable where Value: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}

// MARK: Injected + CustomStringConvertible

extension Injected: CustomStringConvertible where Value: CustomStringConvertible {
    @inlinable
    public var description: String {
        wrappedValue.description
    }
}
