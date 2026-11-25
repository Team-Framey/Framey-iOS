import PresentationCore

@Reducer
public struct HomeFeature {
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }

  @CasePathable
  public enum Action: ViewAction {
    case view(View)
    case delegate(Delegate)

    public enum Delegate {
      case selectTapped
    }

    public enum View {
      case selectTapped
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none

      case .view(.selectTapped):
        return .send(.delegate(.selectTapped))
      }
    }
  }
}
