import PresentationCore
import SwiftUI

@ViewAction(for: LoginFeature.self)
public struct LoginView: View {
  @Bindable public var store: StoreOf<LoginFeature>

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
    .modal(
      isPresented: $store.isSkipModalPresented,
      title: "먼저 둘러볼까요?",
      description: "비회원도 콜라주를 만들 수 있어요.\n보관함과 마이페이지는 로그인 후 이용 가능해요."
    ) {
      Button {
        send(.skipCloseTapped)
      } label: {
        Text("로그인하기")
          .frame(maxWidth: .infinity)
      }

      Button {
        send(.skipConfirmTapped)
      } label: {
        Text("계속 둘러보기")
          .frame(maxWidth: .infinity)
      }
    }
  }
}
