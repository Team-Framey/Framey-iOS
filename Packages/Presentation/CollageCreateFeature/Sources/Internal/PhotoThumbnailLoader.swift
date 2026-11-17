import PresentationCore
import SwiftUI

@DependencyClient
struct PhotoThumbnailLoader: Sendable {
  var load: @Sendable (_ data: Data, _ size: CGSize) async throws -> UIImage
}

extension PhotoThumbnailLoader: DependencyKey {
  static let liveValue = PhotoThumbnailLoader(
    load: { data, size in
      guard let image = UIImage(data: data) else {
        throw PhotoLoadError.invalidImage
      }
      let thumbnail = await image.byPreparingThumbnail(ofSize: size)
      return thumbnail ?? image
    }
  )
}
