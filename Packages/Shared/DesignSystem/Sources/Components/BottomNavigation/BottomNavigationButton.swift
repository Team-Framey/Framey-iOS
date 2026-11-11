import ResoureKit
import SwiftUI

public struct BottomNavigationButton: View {
  private let asset: ResoureKitAsset
  private let selectedAsset: ResoureKitAsset
  private let isSelected: Bool
  private let action: () -> Void

  public init(
    asset: ResoureKitAsset,
    selectedAsset: ResoureKitAsset,
    isSelected: Bool,
    action: @escaping () -> Void
  ) {
    self.asset = asset
    self.selectedAsset = selectedAsset
    self.isSelected = isSelected
    self.action = action
  }

  public var body: some View {
    Button(action: action) {
      currentAsset
        .image
        .resizable()
        .scaledToFit()
        .frame(width: 28, height: 28)
        .padding(8)
    }
    .buttonStyle(BottomNavigationItemButtonStyle(isSelected: isSelected))
  }

  private var currentAsset: ResoureKitAsset {
    isSelected ? selectedAsset : asset
  }
}

// MARK: - ButtonStyle
// TODO: - Bottom Navigation 버튼 스타일 정의되면 변경
// - 드래그 해서 Bottom Navigation 선택 가능한 지
// - Glass 효과 구현

private struct BottomNavigationItemButtonStyle: ButtonStyle {
  let isSelected: Bool

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(
        backgroundColor(configuration.isPressed).color,
        in: .circle
      )
  }

  private func backgroundColor(_ isPressed: Bool) -> FrameyColor {
    if isPressed {
      return .black10
    }
    return isSelected ? .black10 : .clear
  }
}
