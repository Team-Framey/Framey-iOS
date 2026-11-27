import SwiftUI
import PresentationCore

struct LibraryGrid: View {
  private let items: [LibraryItem]

  init(items: [LibraryItem]) {
    self.items = items
  }

  var body: some View {
    ScrollView {
      LazyVGrid(
        columns: columns(),
        spacing: FrameySpacing.s8.value
      ) {
        ForEach(items) { item in
          CollageCard(
            thumbnailURL: item.thumbnailURL,
            themeName: item.themeName,
            dateText: item.dateText
          )
        }
      }
      .padding(.horizontal, .s20)
    }
  }

  private func columns() -> [GridItem] {
    Array(
      repeating: GridItem(
        .flexible(),
        spacing: FrameySpacing.s8.value
      ),
      count: 3
    )
  }
}
