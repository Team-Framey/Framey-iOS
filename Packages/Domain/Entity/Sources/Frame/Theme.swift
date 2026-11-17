import Foundation

public enum Theme: String, CaseIterable, Sendable {
  case simple = "SIMPLE"
  case `default` = "DEFAULT"
  case kitsch = "KITSCH"
}

extension Theme: Identifiable {
  public var id: Theme { self }
}
