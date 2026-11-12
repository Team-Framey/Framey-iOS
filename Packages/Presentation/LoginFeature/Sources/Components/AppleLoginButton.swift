import PresentationCore
import SwiftUI

struct AppleLoginButton: View {
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack(spacing: .zero) {
        ResoureKitAsset.appleIcon.image

        Text("Apple로 계속하기")
          .foregroundStyle(.framey(.white))
          .padding(.horizontal, .s40)
      }
      .frame(maxWidth: .infinity)
      .contentShape(.rect)
    }
    .buttonStyle(
      LoginButtonStyle(background: .gray900)
    )
  }
}
