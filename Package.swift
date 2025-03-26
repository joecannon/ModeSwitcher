// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "ModeSwitcher",
    platforms: [
        .macOS(.v14)
    ],
    targets: [
        .executableTarget(
            name: "ModeSwitcher",
            dependencies: []
        ),
    ]
)