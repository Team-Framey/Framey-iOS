import SwiftUI

extension LinearGradient {
  /// #11B8FF(primary500) (58%) → #FFF4BF(yellow) (100%), 불투명도 100%
  public static func blueGradient(
    startPoint: UnitPoint = .leading,
    endPoint: UnitPoint = .trailing
  ) -> Self {
    Self(
      stops: [
        .init(color: .framey(.primary500), location: 0.58),
        .init(color: .framey(.yellow), location: 1),
      ],
      startPoint: startPoint,
      endPoint: endPoint
    )
  }
}
