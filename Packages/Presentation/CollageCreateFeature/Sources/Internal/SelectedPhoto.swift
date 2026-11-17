import PhotosUI
import SwiftUI

struct SelectedPhoto: Identifiable, Equatable {
  let id: UUID
  let item: PhotosPickerItem
  var data: Data?
  var errorDescription: String?

  mutating func updatePhotoResult(_ result: Result<Data, Error>) {
    switch result {
    case let .success(data):
      self.data = data
      errorDescription = nil

    case let .failure(error):
      data = nil
      errorDescription = error.localizedDescription
    }
  }
}
