import PresentationCore
import SwiftUI

struct LoginHeader: View {
  var body: some View {
    VStack(spacing: .s8) {
      Text("Framey")
        .typography(.enM32)
        .foregroundStyle(.framey(.primary500))

      Text("로그인하고 저장한 콜라주를 다시 만나보세요.")
        .typography(.captionM12)
        .foregroundStyle(.framey(.gray500))
    }
  }
}
