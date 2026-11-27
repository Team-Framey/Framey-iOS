import PresentationCore
import SwiftUI

struct CollageThumbnail: View {
  let url: URL?
  // TODO: - 로드 실패, 로딩 중 이미지 디자인 시안 확정 시 수정 필요
  private let loadingColor: FrameyColor = .gray100
  private let failedColor: FrameyColor = .gray400

  var body: some View {
    AsyncImage(
      url: url,
      transaction: Transaction(
        animation: .easeInOut
      )
    ) { phase in
      switch phase {
      case .empty:
        placeholder(loadingColor)
      case let .success(image):
        image
          .resizable()
          .scaledToFill()
      case .failure:
        placeholder(failedColor)
      @unknown default:
        placeholder(loadingColor)
      }
    }
  }

  private func placeholder(_ color: FrameyColor) -> some View {
    Rectangle()
      .fill(.framey(color))
  }
}
