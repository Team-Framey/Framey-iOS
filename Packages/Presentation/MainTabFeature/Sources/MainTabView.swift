import PresentationCore
import SwiftUI

public struct MainTabView: View {
  public let store: StoreOf<MainTabFeature>

  public init(store: StoreOf<MainTabFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack {
      Text("MainTab")
        .typography(.displaySB36)

      Button {

      } label: {
        Text("Hello")
      }
      .buttonStyle(.frameyPrimary)
      .isLoading(true)

    }
  }
}
