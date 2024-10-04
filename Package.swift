// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HapticFeedback",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "HapticFeedback",
            targets: ["HapticFeedback"]),
    ],
    targets: [
        .target(
            name: "HapticFeedback"),
        .testTarget(
            name: "HapticFeedbackTests",
            dependencies: ["HapticFeedback"]),
    ]
)
