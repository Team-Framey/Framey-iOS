import AppFeature
import PresentationCore
import SwiftUI

@main
struct FrameyApp: App {
  let store: StoreOf<AppFeature>

  init() {
    self.store = Store(initialState: AppFeature.State()) {
      AppFeature()
    }
  }

  var body: some Scene {
    WindowGroup {
      AppView(store: store)
    }
  }
}
