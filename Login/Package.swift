// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Login",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(
            name: "Login",
            targets: ["Login"]),
    ],
    dependencies: [
        .package(path: "../ACMESecureStore"),
        .package(path: "../Architecture"),
        .package(path: "../Entities"),
        .package(path: "../NetworkingCommon"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.1.0"),
        .package(url: "https://github.com/facile-it/FunctionalKit.git", from: "0.22.0"),
    ],
    targets: [
        .target(
            name: "Login",
            dependencies: ["FunctionalKit", "RxSwift"]),
        .testTarget(
            name: "LoginTests",
            dependencies: [
                "Entities",
                "Login",
                "RxSwift",
                "Architecture",
                "ACMESecureStore",
                "NetworkingCommon",
                .product(name: "RxBlocking", package: "RxSwift")
            ]),
    ]
)
