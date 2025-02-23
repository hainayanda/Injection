//
//  TokenSyntax+Extensions.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation
import SwiftSyntax

extension TokenSyntax {
    @inlinable
    func prepend(_ token: TokenSyntax) -> TokenSyntax {
        "\(raw: token.trimmedDescription)\(raw: trimmedDescription)"
    }
}
