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
        .target(name: "PresentationCore"),
      ]
    ),
  ]
)
