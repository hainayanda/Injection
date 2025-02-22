//
//  AttributeName.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//


enum AttributeName {
    case injected
    
    var applicableAttributes: [String] {
        switch self {
        case .injected:
            return ["Injected", "Injection.Inject"]
        }
    }
}
