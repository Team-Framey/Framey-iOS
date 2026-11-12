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
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.framey(.white))
  }
}
