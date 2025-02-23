//
//  Macros.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
@attached(extension, conformances: Injectable, names: arbitrary)
public macro Injectable() = #externalMacro(
    module: "InjectionMacro", type: "InjectableMacro"
)
