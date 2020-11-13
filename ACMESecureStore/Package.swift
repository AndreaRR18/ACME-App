// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ACMESecureStore",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ACMESecureStore",
            targets: ["ACMESecureStore"]),
    ],
    dependencies: [
        .package(path: "../SecureStore")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ACMESecureStore",
            dependencies: ["SecureStore"]),
        .testTarget(
            name: "ACMESecureStoreTests",
            dependencies: ["ACMESecureStore"]),
    ]
)
