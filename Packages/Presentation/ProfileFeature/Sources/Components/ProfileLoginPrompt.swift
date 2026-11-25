import PresentationCore
import SwiftUI

struct ProfileLoginPrompt: View {
  let action: () -> Void

  var body: some View {
    GeometryReader { geometry in
      ScrollView {
        VStack(spacing: .s24) {
          ResoureKitAsset.lockTinted.image
            .resizable()
            .scaledToFit()
            .frame(width: 48, height: 48)
            .accessibilityHidden(true)

          VStack(spacing: .s8) {
            Text("마이페이지는 로그인 후 이용 가능해요.")
              .tracking(-0.18)
              .typography(.titleSB18)
              .foregroundStyle(.framey(.gray900))
              .frame(minHeight: 23)

            Text("로그인하면 계정 정보와 알림 설정을\n확인할 수 있어요.")
              .tracking(-0.14)
              .typography(.bodyR14)
              .lineSpacing(4)
              .foregroundStyle(.framey(.gray700))
              .frame(minHeight: 42)
          }
          .multilineTextAlignment(.center)

          Button(action: action) {
            Text("로그인 페이지로 이동하기")
              .tracking(-0.16)
              .frame(maxWidth: .infinity, minHeight: 24)
          }
          .buttonStyle(.frameyNeutral(.medium))
          .frame(maxWidth: 246)
        }
        .padding(.top, .s32)
        .padding(.horizontal, .s20)
        .padding(.bottom, .s20)
        .frame(maxWidth: .infinity, minHeight: geometry.size.height)
      }
    }
  }
}
