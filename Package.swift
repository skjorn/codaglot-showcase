// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Codaglot",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/twostraws/Ignite.git", branch: "main"),
        .package(url: "https://github.com/swiftlang/swift-markdown.git", from: "0.5.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.7.5")
    ],
    targets: [
        .executableTarget(
            name: "Codaglot",
            dependencies: [
                "Ignite",
                .product(name: "Markdown", package: "swift-markdown"),
                .product(name: "SwiftSoup", package: "swiftsoup")
            ]),
    ]
)
