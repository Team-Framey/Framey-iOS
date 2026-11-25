import SwiftUI

public struct Badge: View {
  public enum Style: Hashable, Sendable {
    case primary
    case secondary

    var backgroundColor: FrameyColor {
      switch self {
      case .primary: .primary500
      case .secondary: .gray700
      }
    }
  }

  private let title: String
  private let style: Style

  public init(
    title: String,
    style: Style = .primary
  ) {
    self.title = title
    self.style = style
  }

  public var body: some View {
    Text(title)
      .typography(.captionSB12)
      .foregroundStyle(.framey(.white))
      .padding(.horizontal, .s12)
      .padding(.vertical, .s4)
      .background(.framey(style.backgroundColor), in: .capsule)
  }
}
