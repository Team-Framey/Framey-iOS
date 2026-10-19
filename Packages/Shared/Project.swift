import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "Shared",
  targets: [
    .shared(
      name: "DesignSystem",
      product: .staticFramework,
      dependencies: [
        .target(name: "ResoureKit"),
      ]
    ),
    .shared(
      name: "ResoureKit",
      product: .staticFramework,
      resources: ["ResoureKit/Resources/**"]
    ),
    .shared(
      name: "GlobalThirdPartyLibrary",
      product: .staticFramework,
      dependencies: [
        .external(name: "ComposableArchitecture"),
      ]
    ),
  ]
)
