// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Clarinete",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Clarinete",
            targets: ["Clarinete"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "git@github.com:betzerra/Pluma.git", exact: .init(0, 1, 0))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Clarinete",
            dependencies: ["Pluma"]),
        .testTarget(
            name: "ClarineteTests",
            dependencies: ["Clarinete"],
            resources: [
                .process("Mocks"),
            ]
        )
    ]
)
