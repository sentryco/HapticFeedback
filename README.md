[![Tests](https://github.com/sentryco/HapticFeedback/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/HapticFeedback/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/ea085160-e70b-4f56-a538-c58224b56a74)](https://codebeat.co/projects/github-com-sentryco-hapticfeedback-main)

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

// Trigger deny haptic feedback
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

## Todo:

- Implement Haptic Feedback Support on macOS

Currently, the haptic feedback functionality is only implemented for iOS, while macOS methods are stubs that do nothing. macOS supports haptic feedback via `NSHapticFeedbackManager`. By implementing haptic feedback on macOS, you can provide a consistent experience across platforms.

**Updated `HapticFeedback.swift`:**

```swift:Sources/HapticFeedback/HapticFeedback.swift
import Foundation

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public class HapticFeedback {
    public enum Kind {
        case entry
        case exit
        case success
        case deny
        case failure
        case extract
    }

    public static func trigger(_ kind: Kind) {
        #if os(iOS)
        playiOS(kind)
        #elseif os(macOS)
        playmacOS(kind)
        #endif
    }

    #if os(iOS)
    private static func playiOS(_ kind: Kind) {
        switch kind {
        case .entry:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .exit:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .deny:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .failure:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .extract:
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }
    #elseif os(macOS)
    private static func playmacOS(_ kind: Kind) {
        let feedbackManager = NSHapticFeedbackManager.defaultPerformer
        switch kind {
        case .entry, .success, .extract:
            feedbackManager.perform(.generic, performanceTime: .default)
        case .exit:
            feedbackManager.perform(.alignment, performanceTime: .default)
        case .deny, .failure:
            feedbackManager.perform(.levelChange, performanceTime: .default)
        }
    }
    #endif
}
```