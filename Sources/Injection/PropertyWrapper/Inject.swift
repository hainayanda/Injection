//
//  Inject.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI

@propertyWrapper
public struct Inject<Wrapped: Injectable>: DynamicProperty {
    @Environment(\.self) var environment: EnvironmentValues
    
    public var wrappedValue: Wrapped
    
    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }
    
    public func update() {
        self.wrappedValue.injectEnvironment(environment)
    }
}

extension Inject where Wrapped: Projecting {
    public var projectedValue: Wrapped.ProjectedValue { wrappedValue.projectedValue }
}

extension Inject: AutoClosurePropertyWrapper where Wrapped: AutoClosurePropertyWrapper {
    public typealias WrappedValue = Wrapped.WrappedValue
    
    public init(wrappedValue thunk: @autoclosure @escaping () -> Wrapped.WrappedValue) {
        self.init(wrappedValue: Wrapped(wrappedValue: thunk()))
    }
}
    
