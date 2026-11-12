import PresentationCore
import SwiftUI

@ViewAction(for: LibraryFeature.self)
public struct LibraryView: View {
  public let store: StoreOf<LibraryFeature>

  public init(store: StoreOf<LibraryFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack {
      AppBar(
        leading: {
          AppBarBrandTitle(color: .primary500)
            .padding(.leading, 20)
        }
      )

      Text("Library")
        .typography(.displaySB36)
        .foregroundStyle(.framey(.gray900))

      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .backgroundStyle(.framey(.white))
  }
}
