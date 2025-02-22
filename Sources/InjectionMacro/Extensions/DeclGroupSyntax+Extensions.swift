//
//  DeclGroupSyntax+Extensions.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation
import SwiftSyntax

extension DeclGroupSyntax {
    var canBeAttachedWithInjectable: Bool {
        self.is(ClassDeclSyntax.self)
        || self.is(StructDeclSyntax.self)
    }
    
    var typeDeclName: TokenSyntax? {
        if let classDecl = self.as(ClassDeclSyntax.self) {
            return classDecl.name
        } else if let structDecl = self.as(StructDeclSyntax.self) {
            return structDecl.name
        } else {
            return nil
        }
    }
}
