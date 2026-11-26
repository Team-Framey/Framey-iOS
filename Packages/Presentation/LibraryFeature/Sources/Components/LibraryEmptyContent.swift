import SwiftUI
import PresentationCore

struct LibraryEmptyContent: View {
  let createAction: () -> Void

  var body: some View {
    VStack(spacing: .s32) {
      VStack(spacing: .s12) {
        ResoureKitAsset.appLogoFillSmall.image

        VStack(spacing: .s8) {
          Text("저장된 콜라주가 없어요.")
            .typography(.titleSB20)
            .foregroundStyle(.framey(.gray700))

          Text("마음에 드는 사진으로\n나만의 콜라주를 만들어보세요!")
            .multilineTextAlignment(.center)
            .typography(.bodyM14)
            .foregroundStyle(.framey(.gray500))
        }
      }

      Button(action: createAction) {
        Text("콜라주 만들기")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.frameyNeutral(.large))
      .padding(.horizontal, .s20)
    }
    .frame(maxHeight: .infinity)
  }
}
