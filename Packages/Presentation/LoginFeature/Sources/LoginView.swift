import PresentationCore
import SwiftUI

@ViewAction(for: LoginFeature.self)
public struct LoginView: View {
  public let store: StoreOf<LoginFeature>

  public init(store: StoreOf<LoginFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack(spacing: .s45) {
      LoginHeader()

      VStack(spacing: .s20) {
        AppleLoginButton {
          send(.appleLoginTapped)
        }

        GoogleLoginButton {
          send(.googleLoginTapped)
        }

        KakaoLoginButton {
          send(.kakaoLoginTapped)
        }
      }
      .padding(.horizontal, .s20)

      SkipLoginButton {
        send(.skipTapped)
      }
    }
    // TODO: - 로딩 관련 UI (전체 overlay) 추가
    .isLoading(store.isLoading)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.framey(.white))
  }
}
