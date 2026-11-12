import SwiftUI

public struct AppBarBrandTitle: View {
  private let color: FrameyColor

  public init(color: FrameyColor) {
    self.color = color
  }

  public var body: some View {
    Text("Framey")
      .typography(.enM24)
      .foregroundStyle(.framey(color))
      .padding(.leading, 20)
  }
}
