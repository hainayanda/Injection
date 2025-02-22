//
//  InjectionTokenSyntaxes.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation
import SwiftSyntax

public struct InjectionTokenSyntaxes {
    
    // MARK: Modifier
    static let `public`: TokenSyntax = "public"
    
    // MARK: Name
    
    static let injectEnvironment: TokenSyntax = "injectEnvironment"
    static let environment: TokenSyntax = "environment"
    
    // MARK: Type
    
    static let environmentValuesType: TokenSyntax = "Injection.EnvironmentValues"
    static let injectableType: TokenSyntax = "Injection.Injectable"
    
    // MARK: Misc
    
    static let underscore: TokenSyntax = "_"
}
