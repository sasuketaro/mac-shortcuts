// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MacShortcuts",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "MacShortcuts",
            path: "Sources/MacShortcuts"
        )
    ]
)
