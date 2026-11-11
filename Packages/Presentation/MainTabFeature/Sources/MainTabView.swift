import PresentationCore
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
        Text("Home")
          .typography(.displaySB32)
          .foregroundStyle(.framey(.black))

      case .library:
        Text("Library")
          .typography(.displaySB32)
          .foregroundStyle(.framey(.black))

      case .profile:
        Text("Profile")
          .typography(.displaySB32)
          .foregroundStyle(.framey(.black))
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea()
    .background(.white)
    .overlay(alignment: .bottom) {
      BottomNavigation(
        items: MainTab.allCases,
        selectedItem: $store.current
      )
    }
  }
}
