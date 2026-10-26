import SwiftUI

// TODO: - 버튼 컴포넌트 관련 미흡한 부분 추후 반영
// - horizontal padding
// - Size에 따른 background color 변경
// - Pressed 정의
// - Loading 정의
public struct FrameyPrimaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  private let size: FrameyButtonSize

  public init(size: FrameyButtonSize) {
    self.size = size
  }

  public func makeBody(configuration: Configuration) -> some View {
    let isPressed = configuration.isPressed && isEnabled
    return configuration.label
      .typography(typography)
      .foregroundStyle(.framey(foregroundColor))
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .background(.framey(backgroundColor))
      .cornerRadius(radius)
      .scaleEffect(isPressed ? 0.97 : 1)
      .animation(
        .interactiveSpring(
          response: 0.22,
          dampingFraction: 0.75,
          blendDuration: 0.1
        ),
        value: isPressed
      )
  }

  private var radius: FrameyRadius {
    FrameyRadius.xl
  }

  private var typography: Typography {
    switch size {
    case .large: .titleSB18
    case .medium: .bodySB16
    case .small: .bodySB16
    case .xsmall: .bodySB16
    }
  }

  private var horizontalPadding: CGFloat {
    switch size {
    case .large: FrameySpacing.s16.value
    case .medium: FrameySpacing.s16.value
    case .small: FrameySpacing.s16.value
    case .xsmall: FrameySpacing.s12.value
    }
  }

  private var verticalPadding: CGFloat {
    switch size {
    case .large: FrameySpacing.s16.value
    case .medium: FrameySpacing.s16.value
    case .small: FrameySpacing.s16.value
    case .xsmall: FrameySpacing.s12.value
    }
  }

  private var foregroundColor: FrameyColor {
    return .white
  }

  private var backgroundColor: FrameyColor {
    guard isEnabled else {
      return .gray400
    }
    switch size {
    case .large:
      return .gray800

    case .medium, .small, .xsmall:
      return .primary500
    }
  }
}
