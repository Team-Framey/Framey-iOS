import SwiftUI

public struct ContentFog: View {
  public enum Direction: Hashable, Sendable {
    case up
    case down
    case leading
    case trailing
  }

  private let direction: Direction
  private let color: Color
  private var colors: [Color] {
    return [
      color.opacity(0),
      color,
    ]
  }

  public init(
    direction: Direction = .up,
    color: Color
  ) {
    self.direction = direction
    self.color = color
  }

  public var body: some View {
    LinearGradient(
      colors: colors,
      startPoint: startPoint,
      endPoint: endPoint
    )
    .allowsHitTesting(false)
  }

  private var startPoint: UnitPoint {
    switch direction {
    case .up: .top
    case .down: .bottom
    case .leading: .leading
    case .trailing: .trailing
    }
  }

  private var endPoint: UnitPoint {
    switch direction {
    case .up: .bottom
    case .down: .top
    case .leading: .trailing
    case .trailing: .leading
    }
  }
}
