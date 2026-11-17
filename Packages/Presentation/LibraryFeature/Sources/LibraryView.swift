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

      Spacer()

      Button {
        send(.createTapped)
      } label: {
        Text("콜라주 만들기")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.frameyNeutral(.large))
      .padding(.horizontal, .s20)

      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.framey(.white))
  }
}
