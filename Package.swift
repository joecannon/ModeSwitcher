// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "ModeSwitcher",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(
            name: "ModeSwitcher",
            targets: ["ModeSwitcher"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "ModeSwitcher",
            dependencies: []
        ),
    ]
)