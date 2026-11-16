import PresentationCore
import SwiftUI

struct ThemeCard: View {
  let title: String
  let description: String

  var body: some View {
    ZStack(alignment: .topLeading) {
      ResoureKitAsset.themePreviewPlaceholder.image

      content()
        .padding(.all, .s20)
    }
    .frame(width: 220, height: 180)
    .shadow(.md)
  }

  private func content() -> some View {
    VStack(
      alignment: .leading,
      spacing: .s4
    ) {
      Text("테마")
        .typography(.captionSB12)
        .foregroundStyle(.framey(.white))
        .padding(.horizontal, .s12)
        .padding(.vertical, .s4)
        .background(.framey(.primary500), in: .capsule)

      VStack(
        alignment: .leading,
        spacing: 2
      ) {
        Text(title)
          .typography(.enM20)
          .foregroundStyle(.framey(.gray800))

        Text(description)
          .typography(.bodyM14)
          .foregroundStyle(.framey(.gray600))
      }
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ThemeCard(
    title: "Default",
    description: "은은한 감성을 더해\n일상을 분위기 있게 담는 프레임"
  )
}
