import PresentationCore
import SwiftUI

struct PhotoSelectButton: View {
  private let action: () -> Void
  private let title = "사진 선택하기"

  init(action: @escaping () -> Void) {
    self.action = action
  }

  var body: some View {
    Button(action: action) {
      Text(title)
        .foregroundStyle(.framey(.white))
        .typography(.bodySB16)
        .padding(.horizontal, 21)
        .padding(.vertical, 14)
    }
    .buttonStyle(PhotoSelectButtonStyle())
  }
}

private struct PhotoSelectButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    let isPressed = configuration.isPressed
    return configuration.label
      .background {
        backgroundView(isPressed: isPressed)
      }
      .overlay {
        overlayView()
      }
      .scaleEffect(isPressed ? 1.08 : 1)
      .animation(.interactiveSpring(response: 0.22, dampingFraction: 0.75), value: isPressed)
  }

  private func backgroundView(isPressed: Bool) -> some View {
    ZStack {
      Capsule().fill(
        Color.hex(0x8C8C8C, opacity: 0.25)
          .shadow(
            .inner(
              color: .framey(.white).opacity(0.5),
              radius: 4
            )
          )
      )

      Capsule().fill(Color.hex(0x171717))
        .blendMode(.plusLighter)

      Capsule()
        .fill(.framey(.white))
        .opacity(isPressed ? 0.15 : 0)
    }
  }

  private func overlayView() -> some View {
    ZStack {
      Capsule().strokeBorder(
        AngularGradient(
          stops: [
            .init(color: .framey(.white).opacity(0.65), location: 0),
            .init(color: .framey(.white).opacity(1), location: 0.06),
            .init(color: .framey(.white).opacity(0.3), location: 0.25),
            .init(color: .framey(.white).opacity(0.3), location: 0.44),
            .init(color: .framey(.white).opacity(1), location: 0.56),
            .init(color: .framey(.white).opacity(0.3), location: 0.75),
            .init(color: .framey(.white).opacity(0.3), location: 0.94),
            .init(color: .framey(.white).opacity(0.65), location: 1),
          ],
          center: .center
        ),
        lineWidth: 1
      )

      Capsule()
        .inset(by: 1)
        .strokeBorder(.framey(.white).opacity(0.25), lineWidth: 1)
        .blur(radius: 1)
    }
  }
}

#Preview {
  PhotoSelectButton(action: {})
    .frameyGradientBackground()
}
