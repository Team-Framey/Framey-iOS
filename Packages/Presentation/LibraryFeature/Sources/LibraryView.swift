import PresentationCore
import SwiftUI

@ViewAction(for: LibraryFeature.self)
public struct LibraryView: View {
  public let store: StoreOf<LibraryFeature>

  public init(store: StoreOf<LibraryFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack(spacing: 0) {
      appBar()

      content()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.framey(.white))
  }

  @ViewBuilder
  private func appBar() -> some View {
    if store.items.isEmpty {
      AppBar(leading: {
        AppBarBrandTitle(color: .primary500)
          .padding(.leading, .s20)
      })
    } else {
      AppBar(center: {
        AppBarTitle("보관함")
      })
    }
  }

  @ViewBuilder
  private func content() -> some View {
    if store.items.isEmpty {
      LibraryEmptyContent {
        send(.createTapped)
      }
      .bottomNavigationPadding()
    } else {
      LibraryGrid(items: store.items)
        .bottomNavigationContentMargins()
    }
  }
}
