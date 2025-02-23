//
//  MemberTypeSyntax+Extensions.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation
import SwiftSyntax

extension VariableDeclSyntax {
    @inlinable
    var name: TokenSyntax? {
        guard let binding =  bindings.first,
              let pattern = binding.pattern.as(IdentifierPatternSyntax.self) else {
            return nil
        }
        return pattern.identifier
    }
    
    @inlinable
    func hasAttribute(_ name: AttributeName) -> Bool {
        attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .contains { $0.is(name) }
    }
}
