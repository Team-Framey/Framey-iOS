import ResoureKit
import SwiftUI

public struct ToastView: View {
  public struct Configuration: Hashable, Sendable {
    public let backgroundColor: FrameyColor
    public let textColor: FrameyColor
    public let radius: FrameyRadius
    public let spacing: CGFloat

    public init(
      backgroundColor: FrameyColor = .black70,
      textColor: FrameyColor = .gray50,
      radius: FrameyRadius = .xl,
      spacing: CGFloat = 8
    ) {
      self.backgroundColor = backgroundColor
      self.textColor = textColor
      self.radius = radius
      self.spacing = spacing
    }
  }

  private let configuration: Configuration
  private let icon: ResoureKitAsset
  private let message: String

  public init(
    configuration: Configuration = .init(),
    icon: ResoureKitAsset,
    message: String
  ) {
    self.configuration = configuration
    self.icon = icon
    self.message = message
  }

  public var body: some View {
    HStack(spacing: configuration.spacing) {
      icon
        .image
        .resizable()
        .scaledToFit()
        .frame(width: 32, height: 32)

      Text(message)
        .typography(.bodyM16)
        .foregroundStyle(.framey(configuration.textColor))
        .frame(maxWidth: .infinity, alignment: .leading)
        .lineLimit(2)
        .multilineTextAlignment(.leading)
    }
    .padding(12)
    .background(.framey(configuration.backgroundColor))
    .cornerRadius(configuration.radius)
  }
}
