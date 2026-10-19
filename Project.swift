import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "Framey",
  configurations: [
    .debug(name: "Debug", xcconfig: "Config/Base.xcconfig"),
    .release(name: "Release", xcconfig: "Config/Base.xcconfig"),
  ],
  targets: [
    .make(
      name: "Framey",
      product: .app,
      bundleId: "com.framey.Framey$(BUNDLE_ID_SUFFIX)",
      infoPlist: .extendingDefault(with: [
        "UILaunchScreen": [:],
        "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
      ]),
      sources: ["Framey/**"],
      resources: ["Framey/Assets.xcassets"],
      dependencies: [
        .project(
          target: "AppFeature",
          path: "Packages/Presentation"
        ),
      ],
      settings: .settings(base: [
        "MARKETING_VERSION": "1.0",
        "CURRENT_PROJECT_VERSION": "1",
      ])
    ),
  ]
)
