//
//  Projecting.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI

public protocol Projecting {
    associatedtype ProjectedValue
    var projectedValue: ProjectedValue { get }
}

// MARK: State + Extensions

extension State: Projecting {
    public typealias ProjectedValue = Binding<Value>
}

// MARK: StateObject + Extensions

extension StateObject: Projecting {
    public typealias ProjectedValue = ObservedObject<ObjectType>.Wrapper
}

// MARK: ObservedObject + Extensions

extension ObservedObject: Projecting {
    public typealias ProjectedValue = ObservedObject<ObjectType>.Wrapper
}
