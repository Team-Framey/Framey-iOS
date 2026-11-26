import SwiftUI

extension View {
  public func typography(_ typography: Typography) -> some View {
    modifier(TypographyModifier(typography: typography))
  }
}

private struct TypographyModifier: ViewModifier {
  let typography: Typography

  func body(content: Content) -> some View {
    // TODO: - Line Height 반영
    content
      .font(typography.font)
      .tracking(typography.tracking)
  }
}
