// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2019",
    products: [
        .executable(
            name: "Day1",
            targets: ["Day1", "Day1Lib"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Day1",
            dependencies: ["Day1Lib"]
        ),
        .target(
            name: "Day1Lib",
            dependencies: []
        ),
        .testTarget(
            name: "Day1LibTests",
            dependencies: ["Day1Lib"]
        ),
    ]
)
