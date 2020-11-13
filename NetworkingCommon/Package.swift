// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "NetworkingCommon",
    products: [
        .library(
            name: "NetworkingCommon",
            targets: ["NetworkingCommon"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.1.1")
    ],
    targets: [
        .target(
            name: "NetworkingCommon",
            dependencies: ["RxSwift"]),
        .testTarget(
            name: "NetworkingCommonTests",
            dependencies: ["NetworkingCommon"]),
    ]
)
