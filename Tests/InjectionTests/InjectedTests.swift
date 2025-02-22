//
//  InjectedTests.swift
//  Injection
//
//  Created by Nayanda Haberty on 23/02/25.
//

import XCTest
import Injection
import Combine

final class InjectedTests: XCTestCase {
    
    var environment: EnvironmentValues!
    var injected: Injected<MockDependency>!
    
    override func setUp() {
        environment = EnvironmentValues()
        injected = Injected(\.mockDependency)
    }
    
    func test_givenInjected_whenInjected_shouldReturnInjectedValue() {
        environment[keyPath: \.mockDependency] = MockDependency()
        injected.injectEnvironment(environment)
        
        XCTAssertEqual(injected.wrappedValue, environment.mockDependency)
    }
    
    func test_givenInjected_whenInjected_shouldPublishValue() {
        environment[keyPath: \.mockDependency] = MockDependency()
        injected.injectEnvironment(environment)
        
        let output = waitingForOutput(from: injected.projectedValue)
        XCTAssertEqual(output, environment.mockDependency)
    }
    
    @discardableResult
    private func waitingForOutput<P: Publisher>(from publisher: P) -> P.Output {
        var captured: P.Output?
        let expectation = expectation(description: "Got output")

        // subscribing
        let cancellable = publisher.sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        } receiveValue: { output in
            captured = output
            expectation.fulfill()
        }

        // waiting
        waitForExpectations(timeout: 1) { error in
            if let error {
                XCTFail("wait for expectation producing error: \(error)")
            }
            cancellable.cancel()
        }

        // check result
        guard let captured else {
            XCTFail("Did not receive any output")
            fatalError()
        }
        return captured
    }
        
}
