import HomeFeature
import LibraryFeature
import PresentationCore
import ProfileFeature
import SwiftUI

@ViewAction(for: MainTabFeature.self)
public struct MainTabView: View {
  @Bindable public var store: StoreOf<MainTabFeature>

  public init(store: StoreOf<MainTabFeature>) {
    self.store = store
  }

  public var body: some View {
    Group {
      switch store.current {
      case .home:
        HomeView(
          store: store.scope(\.home, action: \.tab.home)
        )

      case .library:
        LibraryView(
          store: store.scope(\.library, action: \.tab.library)
        )

      case .profile:
        ProfileView(
          store: store.scope(\.profile, action: \.tab.profile)
        )
      }
    }
    .background(.white)
    .overlay(alignment: .bottom) {
      BottomNavigation(
        items: MainTab.allCases,
        selectedItem: $store.current
      )
    }
  }
}
