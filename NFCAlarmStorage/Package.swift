// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "NFCAlarmStorage",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "NFCAlarmStorage",
            targets: ["NFCAlarmStorage"]),
    ],
    targets: [
        .target(
            name: "NFCAlarmStorage",
            path: "NFCAlarmStorage"
        ),
        .testTarget(
            name: "NFCAlarmStorageTests",
            dependencies: ["NFCAlarmStorage"],
            path: "NFCAlarmStorageTests"
        ),
    ]
)
