import ProjectDescription

extension Project {
  public static func make(
    name: String,
    configurations: [Configuration] = [
      .debug(name: "Debug"),
      .release(name: "Release"),
    ],
    targets: [Target]
  ) -> Project {
    Project(
      name: name,
      options: .options(
        textSettings: .textSettings(usesTabs: false, indentWidth: 2, tabWidth: 2)
      ),
      settings: .settings(
        base: ["SWIFT_VERSION": "6.0"],
        configurations: configurations
      ),
      targets: targets
    )
  }
}
