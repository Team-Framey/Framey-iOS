import Foundation

struct LibraryItem: Hashable, Identifiable {
  let id: Int
  let themeName: String
  let dateText: String // "yy.MM.dd"
  let thumbnailURL: URL?
}
