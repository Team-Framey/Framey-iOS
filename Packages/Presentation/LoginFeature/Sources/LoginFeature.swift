import PresentationCore

@Reducer
public struct LoginFeature {
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }

  @CasePathable
  public enum Action: ViewAction {
    case delegate(Delegate)
    case view(View)

    public enum Delegate {
      case signInSkipped
    }

    public enum View {
      case appleLoginTapped
      case googleLoginTapped
      case kakaoLoginTapped
      case skipTapped
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none

      case .view(.appleLoginTapped):
        // TODO: - Apple Login 진행
        return .none

      case .view(.googleLoginTapped):
        // TODO: - Google Login 진행
        return .none

      case .view(.kakaoLoginTapped):
        // TODO: - Kakao Login 진행
        return .none

      case .view(.skipTapped):
        return .run { send in
          await send(.delegate(.signInSkipped), animation: .default)
        }
      }
    }
  }
}
