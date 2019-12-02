// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let days: [String] = (1...25).lazy
    .map(String.init)
    .map { $0.count == 1 ? "0\($0)" : $0 }

let products: [Product] = days.map { day -> Product in
    .executable(
        name: "Day\(day)",
        targets: ["Day\(day)", "Day\(day)Lib"]
    )
}

let targets: [Target] = days.flatMap { day -> [Target] in
    [
        .target(
            name: "Day\(day)",
            dependencies: [.byName(name: "Day\(day)Lib")]
        ),
        .target(
            name: "Day\(day)Lib",
            dependencies: []
        ),
        .testTarget(
            name: "Day\(day)LibTests",
            dependencies: [.byName(name: "Day\(day)Lib")]
        ),
    ]
}

let package = Package(
    name: "AdventOfCode2019",
    products: products,
    dependencies: [],
    targets: targets
)
