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
      case signInCompleted
    }

    public enum View {
      // TODO: - 제거 필요
      case startTapped
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none

      case .view(.startTapped):
        return .run { send in
          await send(.delegate(.signInCompleted), animation: .default)
        }
      }
    }
  }
}
