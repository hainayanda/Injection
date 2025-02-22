//
//  InjectionMacroPlugin.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct InjectionMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        InjectableMacro.self
    ]
}
