// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ContactsList",
    products: [
        .library(
            name: "ContactsList",
            targets: ["ContactsList"]),
    ],
    dependencies: [
        .package(path: "../ACMESecureStore"),
        .package(path: "../Architecture"),
        .package(path: "../Entities"),
        .package(path: "../NetworkingCommon"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.1.0"),
        .package(url: "https://github.com/facile-it/FunctionalKit.git", from: "0.22.0")
    ],
    targets: [
        .target(
            name: "ContactsList",
            dependencies: [
                "ACMESecureStore",
                "NetworkingCommon",
                "Entities",
                "Architecture",
                "FunctionalKit",
                "RxSwift"
            ]),
        .testTarget(
            name: "ContactsListTests",
            dependencies: ["ContactsList"]),
    ]
)
