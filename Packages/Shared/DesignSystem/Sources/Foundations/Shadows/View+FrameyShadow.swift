import SwiftUI

extension View {
  public func shadow(_ token: FrameyShadow) -> some View {
    shadow(color: token.color, radius: token.radius, x: token.x, y: token.y)
  }
}
