import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "Shared",
  targets: [
    .shared(
      name: "GlobalThirdPartyLibrary",
      product: .staticFramework,
      dependencies: [
        .external(name: "ComposableArchitecture"),
      ]
    ),
  ]
)
