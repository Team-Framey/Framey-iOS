import LoginUseCase
import PresentationCore

@Reducer
public struct LoginFeature {
  @ObservableState
  public struct State: Equatable {
    var isLoading = false
    var isSkipModalPresented = false

    public init() {}
  }

  @CasePathable
  public enum Action: ViewAction {
    case delegate(Delegate)
    case local(Local)
    case view(View)

    public enum Delegate {
      case signInCompleted(FrameyUser)
      case signInSkipped
    }

    public enum Local {
      case signInResponse(Result<FrameyUser?, Error>)
    }

    public enum View: BindableAction {
      case appleLoginTapped
      case binding(BindingAction<State>)
      case googleLoginTapped
      case kakaoLoginTapped
      case skipCloseTapped
      case skipConfirmTapped
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
    BindingReducer(action: \.view)
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none

      case let .local(.signInResponse(.success(user))):
        state.isLoading = false
        guard let user else {
          // User가 없는 경우 로그인 취소
          return .none
        }
        return .send(.delegate(.signInCompleted(user)))

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

      case .view(.binding):
        return .none

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

      case .view(.skipCloseTapped):
        state.isSkipModalPresented = false
        return .none

      case .view(.skipConfirmTapped):
        guard !state.isLoading else {
          return .none
        }
        state.isSkipModalPresented = false
        return .run { send in
          await send(.delegate(.signInSkipped), animation: .default)
        }

      case .view(.skipTapped):
        guard !state.isLoading else {
          return .none
        }
        state.isSkipModalPresented = true
        return .none
      }
    }
  }
}
