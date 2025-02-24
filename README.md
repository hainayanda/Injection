# Injection

`Injection` is a lightweight Swift library that allows injecting environment values from a `View` into its properties (e.g., ViewModel, State). It simplifies dependency injection, improves testability, and makes SwiftUI development more seamless.

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/8e40c3e960d24b82b8f64224f19bda38)](https://app.codacy.com/gh/hainayanda/Injection/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
[![Unit Test](https://github.com/hainayanda/Injection/actions/workflows/test.yml/badge.svg)](https://github.com/hainayanda/Injection/actions/workflows/test.yml)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.9 or higher
- iOS 15.0 or higher
- macOS 12.0 or higher
- tvOS 15.0 or higher
- watchOS 8.0 or higher
- Xcode 15 or higher

## Installation

### Swift Package Manager (Xcode)

To install using Xcode's Swift Package Manager, follow these steps:

- Go to **File > Swift Package > Add Package Dependency**
- Enter the URL: **<https://github.com/hainayanda/Injection.git>**
- Choose **Up to Next Major** for the version rule and set the version to **1.0.0**.
- Click "Next" and wait for the package to be fetched.

### Swift Package Manager (Package.swift)

If you prefer using Package.swift, add Injection as a dependency in your **Package.swift** file:

```swift
dependencies: [
    .package(url: "https://github.com/hainayanda/Injection.git", .upToNextMajor(from: "1.0.0"))
]
```

Then, include it in your target:

```swift
 .target(
    name: "MyModule",
    dependencies: ["Injection"]
)
```

## Usage

### Injecting Environment from View

`Injection` allows you to inject environment values from the view into its properties. This is useful for injecting dependencies into the view model, state, or any other properties that need to be initialized with environment values.

```swift
struct SomeView: View {
    
    // Injecting ObservedObject
    @Inject @ObservedObject var observedObject: ViewModel

    // Injecting StateObject
    @Inject @StateObject var stateObject: ViewModel
    
    // For new SwiftUI Observation API
    @Inject @State var state: ViewModel
    
    // Or just inject any object
    @Inject var plain: ViewModel
    
    // other code
}
```

The object marked with `@Inject` will need to implement the `Injectable` protocol:

```swift
final class ViewModel: Injectable {
    
    // Accessing injected environment values
    @Injected(\.isEnabled) var isEnabled
        
    // other code
}
```

If you are using the `@Observable` macro and intend to use a similar macro for injection, you can use the `@Injectable` macro on top of the class/struct declaration:

```swift
@Injectable
@Observable
final class ViewModel {
        
    // other code
}
```

### Injecting Environment from Injectable

The injection is not limited to the `View`; `Injectable` can inject its environment into another `Injectable` as well. This is useful for injecting dependencies into services, repositories, or any other properties that need environment values:

```swift
final class ViewModel: Injectable {

    @Inject var repository: ViewRepository

    // Accessing injected environment values
    @Injected(\.isEnabled) var isEnabled
        
    // other code
}
```

And don't forget to ensure that the destination also implements `Injectable`:

```swift
final class ViewRepository: Injectable {

    // Accessing injected environment values
    @Injected(\.isEnabled) var isEnabled
        
    // other code
}
```

### Mocking the Dependency for Unit Test

`Injection` also provides a way to mock dependencies for unit testing. All you need to do is call the `mock` method on the `Injectable` object:

```swift
let viewModel = ViewModel()
// Now isEnabled will be false for this viewModel and any Injectable marked as @Inject within this instance.
viewModel.mock(\.isEnabled, with: false)
```

## Contributing

Contributions are welcome! Please follow the guidelines in the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## License

Injection is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Credits

This project is maintained by [Nayanda Haberty](hainayanda@outlook.com).
