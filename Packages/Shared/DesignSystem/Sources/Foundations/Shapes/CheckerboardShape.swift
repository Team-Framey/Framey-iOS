import SwiftUI

public struct CheckerboardShape: Shape {
  private let squareSize: CGFloat

  public init(
    squareSize: CGFloat = 10
  ) {
    self.squareSize = squareSize
  }

  public func path(in rect: CGRect) -> Path {
    var path = Path()

    guard squareSize > 0 else {
      return path
    }

    let columns = Int(ceil(rect.width / squareSize))
    let rows = Int(ceil(rect.height / squareSize))

    for row in 0..<rows {
      for column in 0..<columns {
        guard (row + column).isMultiple(of: 2) else {
          continue
        }

        let square = CGRect(
          x: rect.minX + CGFloat(column) * squareSize,
          y: rect.minY + CGFloat(row) * squareSize,
          width: squareSize,
          height: squareSize
        )

        path.addRect(square.intersection(rect))
      }
    }
    return path
  }
}
