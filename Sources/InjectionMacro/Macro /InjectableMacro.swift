//
//  InjectableMacro.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntax

// MARK: @InjectableMacro Macro implementation

struct InjectableMacro { }

// MARK: @InjectableMacro + ExtensionMacro

extension InjectableMacro: ExtensionMacro {
    static func expansion(of node: AttributeSyntax, attachedTo declaration: some DeclGroupSyntax, providingExtensionsOf type: some TypeSyntaxProtocol, conformingTo protocols: [TypeSyntax], in context: some MacroExpansionContext) throws -> [ExtensionDeclSyntax] {
        guard declaration.canBeAttachedWithInjectable else {
            throw InjectionMacroError.attachedToInvalidType
        }
        return try InjectableExtensionsMacroFactory(source: declaration)
            .expandExtensions()
    }
}
