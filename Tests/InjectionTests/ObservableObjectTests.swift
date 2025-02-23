//
//  ObservableObjectTests.swift
//  Injection
//
//  Created by Nayanda Haberty on 23/02/25.
//

import XCTest
import Injection
import Combine

final class ObservableObjectTests: XCTestCase {
    
    var environment: EnvironmentValues!
    var observableObject: MockObservableObject!
    
    override func setUp() {
        environment = EnvironmentValues()
        observableObject = MockObservableObject()
    }
    
    func test_givenInjected_whenInjected_shouldReturnInjectedValue() {
        environment[keyPath: \.mockDependency] = MockDependency()
        observableObject.injectEnvironment(environment)
        
        XCTAssertEqual(observableObject.mockDependency, environment.mockDependency)
        XCTAssertEqual(observableObject.child.mockDependency, environment.mockDependency)
    }
    
    func test_givenInjected_whenMocked_shouldReturnMockedValue() {
        let mockDependency = MockDependency()
        observableObject.mock(\.mockDependency, with: mockDependency)
        
        XCTAssertEqual(observableObject.mockDependency, mockDependency)
        XCTAssertEqual(observableObject.child.mockDependency, mockDependency)
    }
}
