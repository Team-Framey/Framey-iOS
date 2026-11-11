import SwiftUI

public struct AppBar<Leading: View, Center: View, Trailing: View>: View {
  private let leading: Leading
  private let center: Center
  private let trailing: Trailing

  public init(
    leading: () -> Leading,
    center: () -> Center,
    trailing: () -> Trailing
  ) {
    self.leading = leading()
    self.center = center()
    self.trailing = trailing()
  }

  public var body: some View {
    ZStack {
      center

      HStack {
        leading

        Spacer()

        trailing
      }
    }
    .frame(height: 56)
  }
}
