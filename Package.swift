// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Phones",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "Phones",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"), "PhonesCore"],
            resources: [.copy("Resources/area_codes.txt")]),
        .target(
            name: "PhonesCore",
            dependencies: []),
        .testTarget(
            name: "PhonesTests",
            dependencies: ["Phones"],
            resources: [.copy("Resources/area_codes.txt"),
                        .copy("Resources/phone_numbers.txt")]),
    ]
)
