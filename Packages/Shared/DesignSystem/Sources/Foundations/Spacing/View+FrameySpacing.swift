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
