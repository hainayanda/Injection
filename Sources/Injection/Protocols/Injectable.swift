//
//  Injectable.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI

public protocol Injectable {
    func injectEnvironment(_ environment: EnvironmentValues)
}

// MARK: Injectable + Mocking

extension Injectable {
    @discardableResult
    public func mock<Value>(_ keyPath: WritableKeyPath<EnvironmentValues, Value>, with value: Value) -> Self {
        Mirror(reflecting: self)
            .children
            .compactMap { $0.value as? Injected<Value> }
            .filter { $0.keyPath == keyPath }
            .forEach {
                $0.mock(with: value)
            }
        return self
    }
}

// MARK: ObservableObject + Extensions

extension ObservableObject where Self: Injectable {
    public func injectEnvironment(_ environment: EnvironmentValues){
        Mirror(reflecting: self)
            .children
            .compactMap { $0.value as? Injectable }
            .forEach { $0.injectEnvironment(environment) }
    }
}

// MARK: State + Extensions

extension State: Injectable where Value: Injectable {
    public func injectEnvironment(_ environment: EnvironmentValues) {
        wrappedValue.injectEnvironment(environment)
    }
}

// MARK: StateObject + Extensions

extension StateObject: Injectable where ObjectType: Injectable {
    public func injectEnvironment(_ environment: EnvironmentValues) {
        wrappedValue.injectEnvironment(environment)
    }
}

// MARK: ObservedObject + Extensions

extension ObservedObject: Injectable where ObjectType: Injectable {
    public func injectEnvironment(_ environment: EnvironmentValues) {
        wrappedValue.injectEnvironment(environment)
    }
}
