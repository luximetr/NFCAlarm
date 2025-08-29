// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "NCFAlarmPresentation",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "NCFAlarmPresentation",
            targets: ["NCFAlarmPresentation"]),
    ],
    targets: [
        .target(
            name: "NCFAlarmPresentation",
            path: "NCFAlarmPresentation"
        ),
        .testTarget(
            name: "NCFAlarmPresentationTests",
            dependencies: ["NCFAlarmPresentation"],
            path: "NCFAlarmPresentationTests"
        ),
    ]
)
