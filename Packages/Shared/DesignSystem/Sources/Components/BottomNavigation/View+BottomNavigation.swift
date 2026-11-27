import SwiftUI

extension View {
  public func bottomNavigationContentMargins() -> some View {
    modifier(BottomNavigationContentMarginsModifier())
  }

  public func bottomNavigationPadding() -> some View {
    modifier(BottomNavigationPaddingModifier())
  }
}

private struct BottomNavigationContentMarginsModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .contentMargins(
        .bottom,
        BottomNavigationMetric.height + FrameySpacing.s20.value,
        for: .scrollContent
      )
      .contentMargins(
        .bottom,
        BottomNavigationMetric.height,
        for: .scrollIndicators
      )
  }
}

private struct BottomNavigationPaddingModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(
        .bottom,
        BottomNavigationMetric.height
      )
  }
}
