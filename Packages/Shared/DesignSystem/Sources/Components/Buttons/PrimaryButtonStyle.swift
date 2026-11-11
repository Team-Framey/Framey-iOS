import SwiftUI

// TODO: - 버튼 컴포넌트 관련 미흡한 부분 추후 반영
// - horizontal padding
public struct FrameyPrimaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.isLoading) private var isLoading

  private let size: FrameyButtonSize

  public init(size: FrameyButtonSize) {
    self.size = size
  }

  public func makeBody(configuration: Configuration) -> some View {
    let isPressed = configuration.isPressed && isEnabled
    return configuration.label
      .typography(typography)
      .opacity(isLoading ? 0 : 1)
      .foregroundStyle(.framey(foregroundColor))
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .overlay {
        if isLoading {
          LoadingDots()
            .allowsHitTesting(false)
        }
      }
      .background(.framey(backgroundColor(isPressed)))
      .cornerRadius(radius)
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

  private func backgroundColor(_ isPressed: Bool) -> FrameyColor {
    if isLoading {
      return .primary500
    }
    if !isEnabled {
      return .primary200
    }
    return isPressed ? .primary600 : .primary500
  }
}
