// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "CoordinatorsFoundation",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "CoordinatorsFoundation",
            targets: ["CoordinatorsFoundation"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CoordinatorsFoundation",
            dependencies: []),
        .testTarget(
            name: "CoordinatorsFoundationTests",
            dependencies: ["CoordinatorsFoundation"]),
    ]
)
