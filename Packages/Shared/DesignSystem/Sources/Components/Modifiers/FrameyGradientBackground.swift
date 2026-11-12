import SwiftUI

extension View {
  public func frameyGradientBackground() -> some View {
    modifier(FrameyGradientBackgroundModifier())
  }
}

private struct FrameyGradientBackgroundModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background {
        GeometryReader { geometry in
          let size = geometry.size
          let radius = size.height * 1.67

          RadialGradient(
            stops: [
              .init(color: .hex(0x18AEFF), location: 0),
              .init(color: .hex(0xFFF4BF), location: 0.64),
              .init(color: .hex(0xFFFFFF), location: 1),
            ],
            center: .center,
            startRadius: 0,
            endRadius: radius
          )
          .frame(
            width: radius * 2,
            height: radius * 2
          )
          .scaleEffect(x: 0.65, y: 1)
          .rotationEffect(.degrees(14))
          .position(
            x: size.width * 0.5,
            y: size.height * 0.41
          )
        }
      }
  }
}
