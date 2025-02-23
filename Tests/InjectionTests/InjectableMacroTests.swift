//
//  InjectableMacroTests.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

#if canImport(InjectionMacro) // macro generation can only be run on macos (on pre-compiling phase)
import XCTest
import SwiftSyntaxMacrosTestSupport
@testable import InjectionMacro

final class InjectableMacroTests: XCTestCase {
    
    func test_givenBasicInjectable_whenExpanded_shouldUseBasicInjectableExpansion() {
        assertMacroExpansion(
            basicInjectable, expandedSource: basicInjectableExpansion,
            macros: ["Injectable": InjectableMacro.self]
        )
    }
    
    func test_givenObservableInjectable_whenExpanded_shouldUseObservableInjectableExpansion() {
        assertMacroExpansion(
            observableInjectable, expandedSource: observableInjectableExpansion,
            macros: ["Injectable": InjectableMacro.self]
        )
    }
}

let basicInjectable = #"""
@Injectable
final class ViewModel {
    @Injected(\.someValue) var someValue: Some
    @Injected(\.someOtherValue) var someOtherValue: SomeOther
    @Inject var child: Child = Child()
    var someString: String
}
"""#

let basicInjectableExpansion = #"""
final class ViewModel {
    @Injected(\.someValue) var someValue: Some
    @Injected(\.someOtherValue) var someOtherValue: SomeOther
    @Inject var child: Child = Child()
    var someString: String
}

extension ViewModel : Injection.Injectable {
    public func injectEnvironment(_ environment: Injection.EnvironmentValues) {
        _someValue.injectEnvironment(environment)
        _someOtherValue.injectEnvironment(environment)
        _child.injectEnvironment(environment)
    }
}
"""#

let observableInjectable = #"""
@Injectable
@Observable
final class ViewModel {
    @ObservationIgnored
    @Injected(\.someValue) var someValue: Some

    @ObservationIgnored
    @Injected(\.someOtherValue) var someOtherValue: SomeOther
    
    @ObservationIgnored
    @Inject var child: Child = Child()

    var someString: String
}
"""#

let observableInjectableExpansion = #"""
@Observable
final class ViewModel {
    @ObservationIgnored
    @Injected(\.someValue) var someValue: Some

    @ObservationIgnored
    @Injected(\.someOtherValue) var someOtherValue: SomeOther
    
    @ObservationIgnored
    @Inject var child: Child = Child()

    var someString: String
}

extension ViewModel : Injection.Injectable {
    public func injectEnvironment(_ environment: Injection.EnvironmentValues) {
        _someValue.injectEnvironment(environment)
        _someOtherValue.injectEnvironment(environment)
        _child.injectEnvironment(environment)
    }
}
"""#
#endif
