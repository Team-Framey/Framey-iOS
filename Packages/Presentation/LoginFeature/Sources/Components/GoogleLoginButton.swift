import PresentationCore
import SwiftUI

struct GoogleLoginButton: View {
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack(spacing: .zero) {
        ResoureKitAsset.googleIcon.image

        Text("Google로 계속하기")
          .foregroundStyle(.framey(.gray900))
          .padding(.horizontal, .s40)
      }
      .frame(maxWidth: .infinity)
      .contentShape(.rect)
    }
    .buttonStyle(
      LoginButtonStyle(
        showBorder: true,
        background: .white
      )
    )
  }
}
