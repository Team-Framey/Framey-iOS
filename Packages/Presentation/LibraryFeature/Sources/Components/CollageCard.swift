import SwiftUI
import PresentationCore

struct CollageCard: View {
  let thumbnailURL: URL?
  let themeName: String
  let dateText: String

  var body: some View {
    CollageThumbnail(url: thumbnailURL)
      .aspectRatio(112.0 / 180.0, contentMode: .fit)
      .overlay(alignment: .bottom) {
        info()
      }
      .cornerRadius(.xl)
  }

  private func info() -> some View {
    VStack(alignment: .leading, spacing: 0) {
      Text(themeName)
        .typography(.enM16)
        .foregroundStyle(.framey(.white))
      Text(dateText)
        .typography(.captionR12)
        .foregroundStyle(.framey(.gray300))
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.s8)
    .frame(height: 56)
    .background {
      LinearGradient(
        colors: [
          Color.hex(0x101010).opacity(0),
          Color.hex(0x101010).opacity(1)
        ],
        startPoint: .top,
        endPoint: .bottom
      )
    }
  }
}
