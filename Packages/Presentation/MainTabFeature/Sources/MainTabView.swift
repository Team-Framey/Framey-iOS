import PresentationCore
import SwiftUI

public struct MainTabView: View {
  public let store: StoreOf<MainTabFeature>

  public init(store: StoreOf<MainTabFeature>) {
    self.store = store
  }

  public var body: some View {
    Text("MainTab")
      .typography(.displaySB36)
  }
}
