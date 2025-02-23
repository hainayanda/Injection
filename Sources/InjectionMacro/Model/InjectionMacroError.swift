//
//  InjectionMacroError.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation

public enum InjectionMacroError: CustomStringConvertible, Error {
    case attachedToInvalidType
    
    @inlinable
    public var description: String {
        switch self {
        case .attachedToInvalidType:
            return "@Injectable can only be attached to class or struct"
        }
    }
}

