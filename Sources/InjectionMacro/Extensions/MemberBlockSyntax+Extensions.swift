//
//  MemberBlockSyntax+Extensions.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation
import SwiftSyntax

extension MemberBlockSyntax {
    var variables: [VariableDeclSyntax] {
        members
            .compactMap { $0.as(MemberBlockItemSyntax.self) }
            .compactMap { $0.decl.as(VariableDeclSyntax.self) }
    }
}
