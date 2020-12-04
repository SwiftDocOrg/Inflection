// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Inflection",
    platforms: [
        .macOS(.v10_11)
    ],
    products: [
        .library(
            name: "Inflection",
            targets: ["Inflection"]),
    ],
    targets: [
        .target(
            name: "Inflection",
            dependencies: []),
        .testTarget(
            name: "InflectionTests",
            dependencies: ["Inflection"]),
    ]
)
