import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "Data",
  targets: [
    .shared(
      name: "DataCore",
      product: .staticFramework,
      dependencies: [
        .project(target: "Entity", path: "../Domain"),
        .project(target: "GlobalThirdPartyLibrary", path: "../Shared")
      ]
    ),
    .shared(
      name: "LoginRepository",
      product: .staticFramework,
      dependencies: [
        .target(name: "DataCore"),
      ]
    ),
  ]
)
