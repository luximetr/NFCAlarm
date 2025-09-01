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
    dependencies: [
        .package(url: "https://github.com/ihormyroniuk/AFoundation.git", branch: "development"),
    ],
    targets: [
        .target(
            name: "NFCAlarmPresentation",
            dependencies: [
                "AFoundation"
            ],
            path: "NFCAlarmPresentation",
            resources: [
                .process("Screens/AlarmsList/AlarmsListScreenStrings.xcstrings")
            ]
        ),
        .testTarget(
            name: "NFCAlarmPresentationTests",
            dependencies: ["NFCAlarmPresentation"],
            path: "NFCAlarmPresentationTests"
        ),
    ]
)
