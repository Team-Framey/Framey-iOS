import PresentationCore
import SwiftUI

struct CollageCreateSection<Content: View>: View {
  let title: String
  let subtitle: String?
  let content: Content

  init(
    title: String,
    subtitle: String? = nil,
    content: () -> Content
  ) {
    self.title = title
    self.subtitle = subtitle
    self.content = content()
  }

  var body: some View {
    VStack(spacing: .zero) {
      Text(title)
        .typography(.titleSB18)
        .foregroundStyle(.framey(.gray800))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, .s20)

      if let subtitle {
        Text(subtitle)
          .typography(.bodyM16)
          .foregroundStyle(.framey(.gray500))
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, .s20)
      }

      content
        .padding(.top, subtitle == nil ? .s16 : .s12)
    }
  }
}
