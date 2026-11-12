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
      // TODO: - 로딩 로띠 추가
      Text("Framey")
        .typography(.enM32)
        .foregroundStyle(.framey(.primary100))

      ProgressView()
        .progressViewStyle(.circular)
        .tint(.framey(.primary100))
    }
    .frameyGradientBackground()
    .task {
      await send(.task).finish()
    }
  }
}
