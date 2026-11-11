import ResoureKit
import SwiftUI

public struct AppBarIconButton: View {
  private let icon: ResoureKitAsset
  private let action: () -> Void

  public init(
    icon: ResoureKitAsset,
    action: @escaping () -> Void
  ) {
    self.icon = icon
    self.action = action
  }

  public var body: some View {
    Button(action: action) {
      icon
        .image
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
        .padding(12)
        .contentShape(.rect)
    }
    .buttonStyle(AppBarIconButtonStyle())
  }
}

// MARK: - ButtonStyle
// TODO: - AppBar 버튼 스타일 정의되면 추가

private struct AppBarIconButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(configuration.isPressed ? FrameyColor.black10.color : .clear)
      .cornerRadius(.xl)
  }
}
