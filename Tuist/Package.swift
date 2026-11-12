// swift-tools-version: 6.4
import PackageDescription

let package = Package(
  name: "FrameyDependencies",
  platforms: [
    .iOS(.v17)
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      exact: "1.26.2"
    ),
    .package(
      url: "https://github.com/google/GoogleSignIn-iOS",
      exact: "10.1.0"
    ),
    .package(
      url: "https://github.com/kakao/kakao-ios-sdk",
      exact: "2.30.0"
    ),
    .package(
      url: "https://github.com/pointfreeco/xctest-dynamic-overlay",
      from: "1.13.0"
    ),
  ]
)
