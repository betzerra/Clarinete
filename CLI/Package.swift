// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ClarineteCLI",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Clarinete", path: "../"),
        .package(url: "git@github.com:mtynior/ColorizeSwift.git", from: "1.5.0"),
        .package(url: "git@github.com:apple/swift-argument-parser.git", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "ClarineteCLI",
            dependencies: [
                "Clarinete",
                "ColorizeSwift",
                    .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .testTarget(
            name: "ClarineteCLITests",
            dependencies: ["ClarineteCLI"]),
    ]
)
