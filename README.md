[![Tests](https://github.com/sentryco/HapticFeedback/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/HapticFeedback/actions/workflows/Tests.yml)

# HapticFeedback

HapticFeedback is a Swift library designed to simplify the integration of haptic feedback in iOS applications. It provides a convenient abstraction over the iOS `UIImpactFeedbackGenerator`, making it easier to trigger haptic feedback in response to various user interactions.

## Features

- **Easy Integration**: Simplify the usage of haptic feedback with straightforward API calls.
- **Platform Specific**: Utilizes iOS's native haptic capabilities to provide feedback.
- **Customizable**: Supports different haptic styles and types, tailored to specific user actions.

## Usage
```swift
import HapticFeedback

// Trigger entry haptic feedback
Haptic.trigger(.entry)

// Trigger exit haptic feedback
Haptic.trigger(.exit)

// Trigger success haptic feedback
Haptic.trigger(.success)

// Trigger deniy haptic feedback
Haptic.trigger(.deny)

// Trigger failure haptic feedback
Haptic.trigger(.failure)

// Trigger extracted haptic feedback
Haptic.trigger(.extracted)

```

## Swift Package Manager

```swift
.package(url: "https://github.com/sentryco/HapticFeedback", branch: "main")
```

## License

HapticFeedback is available under the MIT license. See the LICENSE file for more info.
