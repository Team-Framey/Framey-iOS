import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "Presentation",
  targets: [
    .presentation(
      name: "PresentationCore",
      dependencies: [
        .project(target: "Entity", path: "../Domain"),
        .project(target: "DesignSystem", path: "../Shared"),
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
      name: "HomeFeature",
      dependencies: [
        .target(name: "PresentationCore"),
      ]
    ),
    .presentation(
      name: "LibraryFeature",
      dependencies: [
        .target(name: "PresentationCore"),
      ]
    ),
    .presentation(
      name: "LoginFeature",
      dependencies: [
        .target(name: "PresentationCore"),
        .project(target: "LoginUseCase", path: "../Domain")
      ]
    ),
    .presentation(
      name: "MainTabFeature",
      dependencies: [
        .target(name: "HomeFeature"),
        .target(name: "LibraryFeature"),
        .target(name: "ProfileFeature"),
      ]
    ),
    .presentation(
      name: "ProfileFeature",
      dependencies: [
        .target(name: "PresentationCore"),
      ]
    ),
    .presentation(
      name: "SplashFeature",
      dependencies: [
        .target(name: "PresentationCore"),
      ]
    ),
  ]
)
