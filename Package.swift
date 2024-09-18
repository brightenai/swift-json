// swift-tools-version:5.10
import PackageDescription

let package:Package = .init(
    name: "swift-json",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "JSONX", targets: ["JSONX"]),
        .library(name: "JSONAST", targets: ["JSONAST"]),
        .library(name: "JSONLegacy", targets: ["JSONLegacy"]),
    ],
    dependencies: [
        .package(url: "https://github.com/brightenai/swift-grammar.git", branch: "master"),
        .package(url: "https://github.com/apple/swift-testing", .upToNextMinor(
            from: "0.7.0")),
    ],
    targets: [
        .target(name: "JSONAST"),

        .target(name: "JSONDecoding",
            dependencies: [
                .target(name: "JSONAST"),
                .product(name: "Grammar", package: "swift-grammar"),
            ]),

        .target(name: "JSONEncoding",
            dependencies: [
                .target(name: "JSONAST"),
            ]),

        .target(name: "JSONLegacy",
            dependencies: [
                .target(name: "JSONDecoding"),
            ]),

        .target(name: "JSONParsing",
            dependencies: [
                .target(name: "JSONAST"),
                .product(name: "Grammar", package: "swift-grammar"),
            ]),

        .target(name: "JSONX",
            dependencies: [
                .target(name: "JSONDecoding"),
                .target(name: "JSONEncoding"),
                .target(name: "JSONParsing"),
            ],
            path: "Sources/JSON"
			)
    ]
)
