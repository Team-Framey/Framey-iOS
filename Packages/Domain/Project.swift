import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "Domain",
  targets: [
    .shared(
      name: "DomainCore",
      product: .staticFramework,
      dependencies: [
        .target(name: "Entity"),
        .project(target: "GlobalThirdPartyLibrary", path: "../Shared")
      ]
    ),
    .shared(
      name: "Entity",
      product: .staticFramework,
    ),
    .shared(
      name: "LoginUseCase",
      product: .staticFramework,
      dependencies: [
        .target(name: "DomainCore"),
      ]
    ),
  ]
)
