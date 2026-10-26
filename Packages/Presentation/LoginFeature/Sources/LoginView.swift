import PresentationCore
import SwiftUI

@ViewAction(for: LoginFeature.self)
public struct LoginView: View {
  public let store: StoreOf<LoginFeature>

  public init(store: StoreOf<LoginFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack {
      Text("Login")
        .typography(.displaySB36)
        .foregroundStyle(.framey(.gray900))

      Button {
        send(.startTapped)
      } label: {
        // TODO: - 제거 필요
        Text("시작하기")
      }
      .buttonStyle(.frameyPrimary)
    }
  }
}
