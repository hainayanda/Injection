//
//  AttributeSyntax+Extensions.swift
//  Injection
//
//  Created by Nayanda Haberty on 23/02/25.
//

import Foundation
import SwiftSyntax

extension AttributeSyntax {
    
    @inlinable
    func `is`(_ name: AttributeName) -> Bool { name.applicableAttributes.contains(attributeName.trimmedDescription)
    }
}
