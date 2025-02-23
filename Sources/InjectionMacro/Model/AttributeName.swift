//
//  AttributeName.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

@usableFromInline
enum AttributeName {
    case inject
    case injected
    case available
    
    @inlinable
    var applicableAttributes: [String] {
        switch self {
        case .inject:
            return ["Inject", "Injection.Inject"]
        case .injected:
            return ["Injected", "Injection.Injected"]
        case .available:
            return ["available"]
        }
    }
}
