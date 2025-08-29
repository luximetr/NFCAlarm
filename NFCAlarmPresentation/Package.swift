// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "NFCAlarmPresentation",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "NFCAlarmPresentation",
            targets: ["NFCAlarmPresentation"]),
    ],
    targets: [
        .target(
            name: "NFCAlarmPresentation",
            path: "NFCAlarmPresentation"
        ),
        .testTarget(
            name: "NFCAlarmPresentationTests",
            dependencies: ["NFCAlarmPresentation"],
            path: "NFCAlarmPresentationTests"
        ),
    ]
)
