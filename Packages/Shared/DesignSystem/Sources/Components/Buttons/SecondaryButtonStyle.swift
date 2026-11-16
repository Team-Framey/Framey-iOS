import SwiftUI

public struct FrameySecondaryButtonStyle: ButtonStyle {
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
      .foregroundStyle(.framey(foregroundColor))
      .opacity(isLoading ? 0 : 1)
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .overlay {
        if isLoading {
          ButtonSpinner()
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
    }
  }

  private var horizontalPadding: CGFloat {
    switch size {
    case .large: FrameySpacing.s20.value
    case .medium: FrameySpacing.s20.value
    }
  }

  private var verticalPadding: CGFloat {
    switch size {
    case .large: FrameySpacing.s16.value
    case .medium: FrameySpacing.s16.value
    }
  }

  private var foregroundColor: FrameyColor {
    return isEnabled ? .gray900 : .gray400
  }

  private func backgroundColor(_ isPressed: Bool) -> FrameyColor {
    return isPressed ? .gray300 : .gray200
  }
}
