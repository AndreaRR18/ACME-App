// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Architecture",
    products: [
        .library(
            name: "Architecture",
            targets: ["Architecture"]),
    ],
    dependencies: [
        .package(path: "../Entities")
    ],
    targets: [
        .target(
            name: "Architecture",
            dependencies: ["Entities"]),
        .testTarget(
            name: "ArchitectureTests",
            dependencies: ["Architecture"]),
    ]
)
