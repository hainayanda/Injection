//
//  AutoClosurePropertyWrapper.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI

public protocol AutoClosurePropertyWrapper {
    associatedtype WrappedValue
    
    init(wrappedValue: @autoclosure @escaping () -> WrappedValue)
}

extension StateObject: AutoClosurePropertyWrapper {
    public typealias WrappedValue = ObjectType
}
