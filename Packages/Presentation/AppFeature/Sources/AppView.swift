import LoginFeature
import MainTabFeature
import PresentationCore
import SplashFeature
import SwiftUI

public struct AppView: View {
  public let store: StoreOf<AppFeature>

  public init(store: StoreOf<AppFeature>) {
    self.store = store
  }

  public var body: some View {
    Group {
      if let store = store.scope(\.content.login, action: \.content.login) {
        LoginView(store: store)
      }

      if let store = store.scope(\.content.mainTab, action: \.content.mainTab) {
        MainTabView(store: store)
      }

      if let store = store.scope(\.content.splash, action: \.content.splash) {
        SplashView(store: store)
      }
    }
  }
}
