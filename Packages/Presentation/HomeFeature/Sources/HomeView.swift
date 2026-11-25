import PresentationCore
import SwiftUI

@ViewAction(for: HomeFeature.self)
public struct HomeView: View {
  public let store: StoreOf<HomeFeature>

  public init(store: StoreOf<HomeFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack(spacing: 28) {
      AppBar(
        leading: {
          AppBarBrandTitle(color: .white)
            .padding(.leading, 20)
        }
      )

      heroView()
        .padding(.horizontal, .s20)
        .padding(.bottom, 44)

      ThemeCarousel()
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .frameyGradientBackground()
  }

  private func heroView() -> some View {
    VStack(spacing: .s16) {
      ResoureKitAsset.appLogoGlass.image
        .resizable()
        .frame(width: 115.5, height: 115.5)

      VStack(spacing: .s32) {
        HomeIntroText()

        PhotoSelectButton {
          send(.selectTapped)
        }
      }
    }
  }
}

#Preview {
  HomeView(
    store: Store(initialState: HomeFeature.State()) {
      HomeFeature()
    }
  )
}
