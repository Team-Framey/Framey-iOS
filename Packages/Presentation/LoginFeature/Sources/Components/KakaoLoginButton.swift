import PresentationCore
import SwiftUI

struct KakaoLoginButton: View {
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack(spacing: .zero) {
        ResoureKitAsset.kakaoIcon.image

        Text("Kakao로 계속하기")
          .foregroundStyle(.framey(.gray900))
          .padding(.horizontal, .s40)
      }
      .frame(maxWidth: .infinity)
      .contentShape(.rect)
    }
    .buttonStyle(LoginButtonStyle(background: .kakaoBG))
  }
}
