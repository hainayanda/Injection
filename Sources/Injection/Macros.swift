//
//  Macros.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI

@attached(extension, conformances: Injectable, names: arbitrary)
public macro Injectable() = #externalMacro(
    module: "InjectionMacro", type: "InjectableMacro"
)
