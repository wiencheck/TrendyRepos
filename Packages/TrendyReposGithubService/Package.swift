// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TrendyReposGithubService",
    platforms: [
        .iOS(.v17), .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TrendyReposGithubService",
            targets: ["TrendyReposGithubService"]),
    ],
    dependencies: [
        .package(name: "TrendyReposShared", path: "../TrendyReposShared"),
        .package(
            url: "https://github.com/scinfu/SwiftSoup",
            from: "2.8.5"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TrendyReposGithubService",
            dependencies: [
                "TrendyReposShared", "SwiftSoup"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "TrendyReposGithubServiceTests",
            dependencies: [
                "TrendyReposGithubService"
            ]
        ),
    ]
)
