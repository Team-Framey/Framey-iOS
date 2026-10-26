import SwiftUI

extension View {
  public func clipShape(_ token: FrameyRadius) -> some View {
    clipShape(FrameyRoundedShape(token: token))
  }

  public func cornerRadius(_ token: FrameyRadius) -> some View {
    clipShape(token)
  }
}

public struct FrameyRoundedShape: Shape {
  public let token: FrameyRadius

  public init(token: FrameyRadius) {
    self.token = token
  }

  public func path(in rect: CGRect) -> Path {
    RoundedRectangle(cornerRadius: token.value(in: rect.size))
      .path(in: rect)
  }
}
