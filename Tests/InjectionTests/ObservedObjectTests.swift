//
//  ObservedObjectTests.swift
//  Injection
//
//  Created by Nayanda Haberty on 23/02/25.
//

import XCTest
import Injection
import Combine
import SwiftUI

final class ObservedObjectTests: XCTestCase {
    
    var environment: EnvironmentValues!
    var observableObject: MockObservableObject!
    var observedObject: ObservedObject<MockObservableObject>!
    
    override func setUp() {
        environment = EnvironmentValues()
        observableObject = MockObservableObject()
        observedObject = ObservedObject(wrappedValue: self.observableObject)
    }
    
    func test_givenInjected_whenInjected_shouldReturnInjectedValue() {
        environment[keyPath: \.mockDependency] = MockDependency()
        observedObject.injectEnvironment(environment)
        
        XCTAssertEqual(observableObject.mockDependency, environment.mockDependency)
    }
}
