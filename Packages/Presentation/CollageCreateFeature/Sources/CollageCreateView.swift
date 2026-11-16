import PresentationCore
import SwiftUI

@ViewAction(for: CollageCreateFeature.self)
public struct CollageCreateView: View {
  public let store: StoreOf<CollageCreateFeature>

  public init(store: StoreOf<CollageCreateFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack(spacing: .zero) {
      AppBar(
        leading: {
          AppBarIconButton(icon: .chevronLeft) {
            send(.closeTapped)
          }
        }
      )

      CollageCreateContent(store: store)

      Button {
        send(.createTapped)
      } label: {
        Text("콜라주 만들기")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.frameyNeutral(.large))
      .disabled(!store.isEnabled)
      .padding(.horizontal, .s20)
      .padding(.bottom, .s4)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.framey(.white))
  }
}
