import PresentationCore
import SwiftUI

struct ThemeCard: View {
  let title: String
  let description: String
  let backgroundImage: Image

  var body: some View {
    ZStack(alignment: .topLeading) {
      backgroundImage

      content()
        .padding(.all, .s20)
    }
    .frame(width: 220, height: 180)
    .cornerRadius(.`2xl`)
    .shadow(.md)
  }

  private func content() -> some View {
    VStack(
      alignment: .leading,
      spacing: .s4
    ) {
      Badge(title: "테마", style: .secondary)

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
    description: "은은한 감성을 더해\n일상을 분위기 있게 담는 프레임",
    backgroundImage: ResoureKitAsset.themePreviewDefault.image
  )
}
