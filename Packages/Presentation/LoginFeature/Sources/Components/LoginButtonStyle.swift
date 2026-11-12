import PresentationCore
import SwiftUI

struct LoginButtonStyle: ButtonStyle {
  let showBorder: Bool
  let background: FrameyColor

  init(
    showBorder: Bool = false,
    background: FrameyColor
  ) {
    self.showBorder = showBorder
    self.background = background
  }

  func makeBody(configuration: Configuration) -> some View {
    let isPressed = configuration.isPressed
    return configuration.label
      .typography(.titleM18)
      .padding(.vertical, 10)
      .background {
        shape
          .fill(.framey(background))
      }
      .overlay {
        shape
          .fill(.framey(.black))
          .opacity(isPressed ? 0.2 : 0)
      }
      .overlay {
        shape
          .stroke(.framey(.gray200), lineWidth: showBorder ? 1 : 0)
      }
      .animation(
        .interactiveSpring(
          response: 0.22,
          dampingFraction: 0.75,
          blendDuration: 0.1
        ),
        value: isPressed
      )
  }

  private var shape: some Shape {
    FrameyRoundedShape(token: .xl)
  }
}
