//
//  StateTests.swift
//  Injection
//
//  Created by Nayanda Haberty on 23/02/25.
//

import XCTest
import Injection
import Combine
import SwiftUI

final class StateTests: XCTestCase {
    
    var environment: EnvironmentValues!
    var observableObject: MockObservableObject!
    var state: State<MockObservableObject>!
    
    override func setUp() {
        environment = EnvironmentValues()
        observableObject = MockObservableObject()
        state = State(wrappedValue: observableObject)
    }
    
    func test_givenInjected_whenInjected_shouldReturnInjectedValue() {
        environment[keyPath: \.mockDependency] = MockDependency()
        state.injectEnvironment(environment)
        
        XCTAssertEqual(observableObject.mockDependency, environment.mockDependency)
    }
}
