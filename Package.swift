// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PassaggIO",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "PassaggIO",
            targets: [
                "PassaggIO"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PassaggIO"),
        .testTarget(
            name: "PassaggIOTests",
            dependencies: ["PassaggIO"]),
    ]
)
