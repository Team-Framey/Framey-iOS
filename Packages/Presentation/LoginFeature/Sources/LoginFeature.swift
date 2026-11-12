import LoginUseCase
import PresentationCore

@Reducer
public struct LoginFeature {
  @ObservableState
  public struct State: Equatable {
    var isLoading = false

    public init() {}
  }

  @CasePathable
  public enum Action: ViewAction {
    case delegate(Delegate)
    case local(Local)
    case view(View)

    public enum Delegate {
      case signInCompleted
      case signInSkipped
    }

    public enum Local {
      case signInResponse(Result<AuthenticationPhase?, Error>)
    }

    public enum View {
      case appleLoginTapped
      case googleLoginTapped
      case kakaoLoginTapped
      case skipTapped
    }
  }

  private enum CancelID {
    case apple
    case google
    case kakao
  }

  @Dependency(LoginUseCase.self) private var useCase

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none

      case let .local(.signInResponse(.success(phase))):
        state.isLoading = false
        guard let phase else {
          // Phase가 없는 경우 로그인 취소
          return .none
        }

        // TODO: - Phase를 따른 케이스 추가 + 로그인 처리
        switch phase {
        case .signInCompleted:
          return .send(.delegate(.signInCompleted))

        case .termsAgreementRequired:
          return .send(.delegate(.signInCompleted))
        }

      case let .local(.signInResponse(.failure(error))):
        state.isLoading = false
        // TODO: - 로그인 실패 케이스 추가 (Toast or Modal ...)
        print(error.localizedDescription)
        return .none

      case .view(.appleLoginTapped):
        guard !state.isLoading else {
          return .none
        }

        state.isLoading = true
        return .run { [useCase] send in
          for await result in await useCase.appleLoginRequest() {
            await send(.local(.signInResponse(Result {
              try await useCase.appleLoginOnCompletion(result)
            })))
          }
        }.cancellable(id: CancelID.apple, cancelInFlight: true)

      case .view(.googleLoginTapped):
        guard !state.isLoading else {
          return .none
        }

        state.isLoading = true
        return .run { [useCase] send in
          await send(.local(.signInResponse(Result {
            try await useCase.googleLoginRequest()
          })))
        }.cancellable(id: CancelID.google, cancelInFlight: true)

      case .view(.kakaoLoginTapped):
        guard !state.isLoading else {
          return .none
        }

        state.isLoading = true
        return .run { [useCase] send in
          await send(.local(.signInResponse(Result {
            try await useCase.kakaoLoginRequest()
          })))
        }.cancellable(id: CancelID.kakao, cancelInFlight: true)

      case .view(.skipTapped):
        guard !state.isLoading else {
          return .none
        }
        return .run { send in
          await send(.delegate(.signInSkipped), animation: .default)
        }
      }
    }
  }
}
