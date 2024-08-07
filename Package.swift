// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WZDateSlider",
    platforms: [.macOS(.v10_15), .iOS(.v14), .tvOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WZDateSlider",
            targets: ["WZDateSlider"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WZDateSlider"),
        .testTarget(
            name: "WZDateSliderTests",
            dependencies: ["WZDateSlider"]
        ),
    ]
)
