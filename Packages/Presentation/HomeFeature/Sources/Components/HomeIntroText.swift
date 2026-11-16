import PresentationCore
import SwiftUI

struct HomeIntroText: View {
  var body: some View {
    VStack(spacing: .s12) {
      Text("어떤 순간을 담아볼까요?")
        .typography(.titleSB20)
        .foregroundStyle(.framey(.white))

      Text("최대 6장의 사진을 선택하면\nFramey가 자동으로 콜라주를 만들어줘요.")
        .typography(.bodyM14)
        .multilineTextAlignment(.center)
        .foregroundStyle(.framey(.white))
        .opacity(0.7)
    }
  }
}

#Preview {
  HomeIntroText()
    .frameyGradientBackground()
}
