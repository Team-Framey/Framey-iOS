import SwiftUI

public struct AppBarTitle: View {
  private let title: String
  private let subtitle: String?

  public init(
    _ title: String,
    subtitle: String? = nil
  ) {
    self.title = title
    self.subtitle = subtitle
  }

  public var body: some View {
    VStack(spacing: .zero) {
      Text(title)
        .typography(.titleSB18)
        .foregroundStyle(.framey(.gray900))

      if let subtitle {
        Text(subtitle)
          .typography(.captionR12)
          .foregroundStyle(.framey(.gray400))
      }
    }
    .lineLimit(1)
  }
}
