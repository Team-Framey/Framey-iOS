import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "Presentation",
  targets: [
    .presentation(
      name: "PresentationCore",
      dependencies: [
        .project(target: "GlobalThirdPartyLibrary", path: "../Shared"),
      ]
    ),
    .presentation(
      name: "AppFeature",
      dependencies: [
        .target(name: "SplashFeature"),
        .target(name: "LoginFeature"),
        .target(name: "MainTabFeature"),
      ]
    ),
    .presentation(
      name: "SplashFeature",
      dependencies: [
        .target(name: "PresentationCore"),
      ]
    ),
    .presentation(
      name: "LoginFeature",
      dependencies: [
        .target(name: "PresentationCore"),
      ]
    ),
    .presentation(
      name: "MainTabFeature",
      dependencies: [
        .target(name: "PresentationCore"),
      ]
    ),
  ]
)
