//
//  MockObservable.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI
import Injection
import Observation

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
@Injectable
@Observable
final class MockObservable {
    @ObservationIgnored
    @Injected(\.mockDependency) var mockDependency: MockDependency
    
    @ObservationIgnored
    @Inject var child: Child = Child()
}

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
extension MockObservable {
    final class Child: Injectable {
        @Injected(\.mockDependency) var mockDependency: MockDependency
    }
}

final class MockObservableObject: ObservableObject, Injectable {
    @Injected(\.mockDependency) var mockDependency: MockDependency
    @Inject var child: Child = Child()
}

extension MockObservableObject {
    final class Child: Injectable {
        @Injected(\.mockDependency) var mockDependency: MockDependency
    }
}

struct MockDependency: Hashable {
    var identifier: UUID = UUID()
}

extension EnvironmentValues {
    @Entry var mockDependency: MockDependency = MockDependency()
}
