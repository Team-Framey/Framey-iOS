import PresentationCore
import SwiftUI

@ViewAction(for: SplashFeature.self)
public struct SplashView: View {
  public let store: StoreOf<SplashFeature>

  public init(store: StoreOf<SplashFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack {
      Text("Splash")
        .typography(.displaySB36)

      ProgressView()
        .progressViewStyle(.circular)
    }
    .task {
      await send(.task).finish()
    }
  }
}
