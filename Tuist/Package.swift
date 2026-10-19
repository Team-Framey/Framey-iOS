// swift-tools-version: 6.4
import PackageDescription

let package = Package(
  name: "FrameyDependencies",
  platforms: [.iOS(.v17)],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      exact: "1.26.2"
    ),
  ]
)
