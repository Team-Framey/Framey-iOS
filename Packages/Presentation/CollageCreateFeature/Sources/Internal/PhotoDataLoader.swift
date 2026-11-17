import PhotosUI
import PresentationCore
import SwiftUI

@DependencyClient
struct PhotoDataLoader: Sendable {
  var load: @Sendable (_ item: PhotosPickerItem) async throws -> Data
}

extension PhotoDataLoader: DependencyKey {
  static let liveValue = PhotoDataLoader(
    load: { item in
      guard let data = try await item.loadTransferable(type: Data.self) else {
        throw PhotoLoadError.invalidImage
      }
      return data
    }
  )
}
