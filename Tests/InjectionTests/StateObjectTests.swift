//
//  StateObjectTests.swift
//  Injection
//
//  Created by Nayanda Haberty on 23/02/25.
//

import XCTest
import Injection
import Combine
import SwiftUI

final class StateObjectTests: XCTestCase {
    
    var environment: EnvironmentValues!
    var observableObject: MockObservableObject!
    var stateObject: StateObject<MockObservableObject>!
    
    override func setUp() {
        environment = EnvironmentValues()
        observableObject = MockObservableObject()
        stateObject = StateObject(wrappedValue: self.observableObject)
    }
    
    func test_givenInjected_whenInjected_shouldReturnInjectedValue() {
        environment[keyPath: \.mockDependency] = MockDependency()
        stateObject.injectEnvironment(environment)
        
        XCTAssertEqual(observableObject.mockDependency, environment.mockDependency)
    }
}
