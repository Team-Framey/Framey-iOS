import PresentationCore
import SwiftUI

struct CollageCreatePhotoRow: View {
  @Dependency(PhotoThumbnailLoader.self) private var loader
  @Environment(\.displayScale) private var scale
  let photo: SelectedPhoto
  let delete: () -> Void

  @State private var thumbnail: UIImage?

  var body: some View {
    content
      .frame(width: Metric.width, height: Metric.height)
      .cornerRadius(.xl)
      .contentShape(.rect)
      .allowsHitTesting(false)
      .overlay(alignment: .topTrailing) {
        Button(action: delete) {
          ResoureKitAsset.deleteCircleFill.image
            .resizable()
            .frame(width: 24, height: 24)
            .opacity(0.5)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .padding(.top, .s10)
        .padding(.trailing, .s8)
      }
      .task(id: photo) {
        await task()
      }
  }

  @ViewBuilder
  private var content: some View {
    if let thumbnail {
      Image(uiImage: thumbnail)
        .resizable()
        .scaledToFill()
    } else {
      CheckerboardShape(squareSize: 10)
        .fill(Color.hex(0xFAFAFA))
        .background(Color.hex(0xEBEBEB))
    }
  }

  private func task() async {
    thumbnail = nil

    guard let data = photo.data else {
      return
    }
    thumbnail = try? await loader.load(
      data: data,
      size: .init(width: Metric.width * scale, height: Metric.height * scale)
    )
  }
}

// MARK: - CollageCreatePhotoAddButton

// TODO: - 사진 선택 버튼 디자인 요청 필요

struct CollageCreatePhotoAddButton: View {
  let count: Int
  let totalCount: Int
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      VStack(spacing: .s8) {
        ResoureKitAsset.gallery.image
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(width: 25, height: 25)

        Text("\(count)/\(totalCount)")
          .typography(.bodyM14)
      }
      .foregroundStyle(.framey(.gray500))
      .frame(width: Metric.width, height: Metric.height)
      .contentShape(.rect)
      .overlay {
        FrameyRoundedShape(token: .xl)
          .stroke(.framey(.gray200), lineWidth: 1)
      }
    }
    .buttonStyle(.plain)
  }
}

// MARK: - Metric

private enum Metric {
  static let width: CGFloat = 108
  static let height: CGFloat = 151
}
