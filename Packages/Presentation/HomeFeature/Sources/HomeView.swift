import PresentationCore
import SwiftUI

@ViewAction(for: HomeFeature.self)
public struct HomeView: View {
  public let store: StoreOf<HomeFeature>

  public init(store: StoreOf<HomeFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack {
      AppBar(
        leading: {
          AppBarBrandTitle(color: .white)
            .padding(.leading, 20)
        }
      )

      Text("Home")
        .typography(.displaySB36)
        .foregroundStyle(.framey(.primary100))


      Spacer()
    }
    .frameyGradientBackground()
  }
}
