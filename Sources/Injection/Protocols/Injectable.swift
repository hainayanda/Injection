//
//  Injectable.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI

public protocol Injectable {
    func injectEnvironment(_ environment: EnvironmentValues)
    #if DEBUG
    @discardableResult
    func mock<Value>(_ keyPath: WritableKeyPath<EnvironmentValues, Value>, with value: Value) -> Self
    #endif
}

// MARK: Default Implementation

extension Injectable {
    @inlinable
    public func injectEnvironment(_ environment: EnvironmentValues) {
        Mirror(reflecting: self)
            .children
            .compactMap { $0.value as? Injectable }
            .forEach { $0.injectEnvironment(environment) }
    }
}

// MARK: Injectable + Mocking

#if DEBUG
extension Injectable {
    @inlinable
    @discardableResult
    public func mock<Value>(_ keyPath: WritableKeyPath<EnvironmentValues, Value>, with value: Value) -> Self {
        Mirror(reflecting: self)
            .children
            .compactMap { $0.value as? Injectable }
            .forEach { $0.mock(keyPath, with: value) }
        return self
    }
}
#endif

// MARK: State + Injectable

extension State: Injectable {
    @inlinable
    public func injectEnvironment(_ environment: EnvironmentValues) {
        guard let injectable = wrappedValue as? Injectable else {
            return
        }
        injectable.injectEnvironment(environment)
    }
}

// MARK: StateObject + Injectable

extension StateObject: Injectable {
    @inlinable
    public func injectEnvironment(_ environment: EnvironmentValues) {
        guard let injectable = wrappedValue as? Injectable else {
            return
        }
        injectable.injectEnvironment(environment)
    }
}

// MARK: ObservedObject + Injectable

extension ObservedObject: Injectable {
    @inlinable
    public func injectEnvironment(_ environment: EnvironmentValues) {
        guard let injectable = wrappedValue as? Injectable else {
            return
        }
        injectable.injectEnvironment(environment)
    }
}
