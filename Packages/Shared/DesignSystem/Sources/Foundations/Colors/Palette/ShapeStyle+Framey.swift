import SwiftUI

extension ShapeStyle where Self == Color {
  public static func framey(_ token: FrameyColor) -> Color {
    token.color
  }
}

extension ShapeStyle where Self == LinearGradient {
  public static func framey(linear gradient: LinearGradient) -> Self {
    gradient
  }
}

extension ShapeStyle where Self == AngularGradient {
  public static func framey(angular gradient: AngularGradient) -> Self {
    gradient
  }
}
