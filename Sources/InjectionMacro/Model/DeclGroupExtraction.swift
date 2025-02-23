//
//  DeclGroupExtraction.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftSyntax

struct DeclGroupExtraction {
    let source: DeclGroupSyntax
    
    @inlinable
    var name: TokenSyntax {
        get throws {
            guard let name = source.typeDeclName else {
                throw InjectionMacroError.attachedToInvalidType
            }
            return name
        }
    }
    
    @inlinable
    var availableAttributes: [AttributeListSyntax.Element] {
        source.attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .filter { $0.is(.available) }
            .map { .attribute($0) }
    }
    
    @inlinable
    var injectedVariablesName: [TokenSyntax] {
        source.memberBlock.variables
            .filter { $0.hasAttribute(.injected) || $0.hasAttribute(.inject) }
            .compactMap { $0.name }
    }
    
    @inlinable
    init(source: DeclGroupSyntax) {
        self.source = source
    }
}


