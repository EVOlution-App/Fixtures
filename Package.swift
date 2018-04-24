// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Fixtures",
    products: [
        .executable(
            name: "fixtures",
            targets: ["Fixtures"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/unnamedd/evoapp-datamodels.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "Fixtures",
            dependencies: ["DataModelsKit"],
            path: "Sources"
        )
    ]
)
