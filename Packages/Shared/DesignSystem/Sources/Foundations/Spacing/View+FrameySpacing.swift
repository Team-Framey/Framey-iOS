import SwiftUI

extension View {
  public func padding(_ spacing: FrameySpacing) -> some View {
    padding(.all, spacing.value)
  }

  public func padding(
    _ edges: Edge.Set,
    _ spacing: FrameySpacing
  ) -> some View {
    padding(edges, spacing.value)
  }
}

extension VStack {
  @inlinable public init(
    alignment: HorizontalAlignment = .center,
    spacing: FrameySpacing,
    @ContentBuilder content: () -> Content
  ) {
    self.init(
      alignment: alignment,
      spacing: spacing.value,
      content: content
    )
  }
}

extension HStack {
  @inlinable public init(
    alignment: VerticalAlignment = .center,
    spacing: FrameySpacing,
    @ContentBuilder content: () -> Content
  ) {
    self.init(
      alignment: alignment,
      spacing: spacing.value,
      content: content
    )
  }
}
