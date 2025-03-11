// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SplunkTestGithubService",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SplunkTestGithubService",
            targets: ["SplunkTestGithubService"]),
    ],
    dependencies: [
        .package(name: "SplunkTestShared", path: "../SplunkTestShared"),
        .package(
            url: "https://github.com/scinfu/SwiftSoup",
            from: "2.8.5"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SplunkTestGithubService",
            dependencies: [
                "SplunkTestShared", "SwiftSoup"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "SplunkTestGithubServiceTests",
            dependencies: [
                "SplunkTestGithubService"
            ]
        ),
    ]
)
