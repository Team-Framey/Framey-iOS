import ProjectDescription

extension Target {
  public static func make(
    name: String,
    product: Product,
    bundleId: String,
    infoPlist: InfoPlist = .default,
    sources: SourceFilesList,
    resources: ResourceFileElements? = nil,
    dependencies: [TargetDependency] = [],
    settings: Settings? = nil
  ) -> Target {
    .target(
      name: name,
      destinations: [.iPhone],
      product: product,
      bundleId: bundleId,
      deploymentTargets: .iOS("17.0"),
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      dependencies: dependencies,
      settings: settings
    )
  }

  public static func presentation(
    name: String,
    resources: ResourceFileElements? = nil,
    dependencies: [TargetDependency] = []
  ) -> Target {
    .make(
      name: name,
      product: .staticFramework,
      bundleId: "com.framey.Presentation.\(name)",
      sources: ["\(name)/Sources/**"],
      resources: resources,
      dependencies: dependencies
    )
  }

  public static func shared(
    name: String,
    product: Product,
    infoPlist: InfoPlist = .default,
    resources: ResourceFileElements? = nil,
    dependencies: [TargetDependency] = []
  ) -> Target {
    .make(
      name: name,
      product: product,
      bundleId: "com.framey.Shared.\(name)",
      sources: ["\(name)/Sources/**"],
      resources: resources,
      dependencies: dependencies
    )
  }
}
