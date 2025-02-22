//
//  InjectableExtensionsMacroFactory.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftSyntax

struct InjectableExtensionsMacroFactory {
    typealias ITS = InjectionTokenSyntaxes
    
    let extraction: DeclGroupExtraction
    
    init(source: DeclGroupSyntax) {
        extraction = DeclGroupExtraction(source: source)
    }
    
    func expandExtensions() throws -> [ExtensionDeclSyntax] {
        return try [
            ExtensionDeclSyntax(
                attributes: AttributeListSyntax(extraction.availableAttributes),
                extendedType: IdentifierTypeSyntax(name: extraction.name),
                inheritanceClause: InheritanceClauseSyntax(
                    inheritedTypes: InheritedTypeListSyntax {
                        InheritedTypeSyntax(type: IdentifierTypeSyntax(name: ITS.injectableType))
                    }
                ),
                memberBlock: MemberBlockSyntax {
                    functionDecl()
                }
            )
        ]
    }
    
    /// Will generate function declaration like this:
    /// ```swift
    /// public func injectEnvironment(_ environment: EnvironmentValues) {
    ///     _someValue.injectEnvironment(environment)
    ///     _someOtherValue.injectEnvironment(environment)
    /// }
    /// ```
    private func functionDecl() -> FunctionDeclSyntax {
        FunctionDeclSyntax(
            modifiers: DeclModifierListSyntax {
                DeclModifierSyntax(name: ITS.public)
            },
            name: ITS.injectEnvironment,
            signature: functionSignature()) {
                for variableName in extraction.injectedVariablesName {
                    functionBodyCodeBlock(for: variableName)
                }
            }
    }
    
    /// Will generate function signature like this:
    /// `(_ environment: EnvironmentValues)`
    private func functionSignature() -> FunctionSignatureSyntax {
        FunctionSignatureSyntax(
            parameterClause: FunctionParameterClauseSyntax(
                parameters: FunctionParameterListSyntax {
                    FunctionParameterSyntax(
                        firstName: ITS.underscore,
                        secondName: ITS.environment,
                        type: IdentifierTypeSyntax(name: ITS.environmentValuesType)
                    )
                }
            )
        )
    }
    
    /// Will generate code block like this:
    /// `_someValue.injectEnvironment(with: environment)`
    private func functionBodyCodeBlock(for variableName: TokenSyntax) -> CodeBlockItemSyntax {
        CodeBlockItemSyntax(
            item: .expr(
                ExprSyntax(injectingFunctionBodyExpr(for: variableName))
            )
        )
    }
    
    /// Will generate expression like this:
    /// `_someValue.injectEnvironment(environment)`
    private func injectingFunctionBodyExpr(for variableName: TokenSyntax) -> ExprSyntaxProtocol {
        FunctionCallExprSyntax(
            calledExpression: MemberAccessExprSyntax(
                base: DeclReferenceExprSyntax(baseName: variableName.prepend(ITS.underscore)),
                declName: DeclReferenceExprSyntax(baseName: ITS.injectEnvironment)
            ),
            leftParen: .leftParenToken(),
            arguments: LabeledExprListSyntax {
                LabeledExprSyntax(
                    expression: DeclReferenceExprSyntax(baseName: ITS.environment)
                )
            },
            rightParen: .rightParenToken()
        )
    }
}
