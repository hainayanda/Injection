//
//  DeclGroupExtraction.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftSyntax

struct DeclGroupExtraction {
    let source: DeclGroupSyntax
    
    var name: TokenSyntax {
        get throws {
            guard let name = source.typeDeclName else {
                throw InjectionMacroError.attachedToInvalidType
            }
            return name
        }
    }
    
    var availableAttributes: [AttributeListSyntax.Element] {
        source.attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .filter { attribute in
                attribute.attributeName.trimmedDescription == "available"
            }
            .map { .attribute($0) }
    }
    
    var injectedVariablesName: [TokenSyntax] {
        source.memberBlock.variables
            .filter { $0.hasAttribute(.injected) }
            .compactMap { $0.name }
    }
    
    init(source: DeclGroupSyntax) {
        self.source = source
    }
}


