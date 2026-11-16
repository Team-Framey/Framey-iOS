import PresentationCore
import SwiftUI

struct PhotoSelectButton: View {
  private let action: () -> Void

  init(action: @escaping () -> Void) {
    self.action = action
  }

  var body: some View {
    Button(action: action) {
      Text("사진 선택하기")
        .foregroundStyle(.framey(.white))
        .typography(.bodySB16)
        .padding(.horizontal, 21)
        .padding(.vertical, 14)
        // glassEffect는 26.0 이상만 가능하므로 커스텀
        .background {
          backgroundView()
        }
        .overlay {
          overlayView()
        }
    }
  }

  private func backgroundView() -> some View {
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
