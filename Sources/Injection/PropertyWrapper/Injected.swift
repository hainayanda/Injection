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
    
    let keyPath: KeyPath<EnvironmentValues, Value>
    
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
    
    func mock(with value: Value) {
        _wrappedValue = value
    }
}

extension Injected: Equatable where Value: Equatable {
    public static func == (lhs: Injected<Value>, rhs: Injected<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}

extension Injected: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}

extension Injected: CustomStringConvertible where Value: CustomStringConvertible {
    public var description: String {
        wrappedValue.description
    }
}
