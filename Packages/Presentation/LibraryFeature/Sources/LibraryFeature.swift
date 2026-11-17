import PresentationCore

@Reducer
public struct LibraryFeature {
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }

  @CasePathable
  public enum Action: ViewAction {
    case delegate(Delegate)
    case view(View)

    public enum Delegate {
      case createTapped
    }

    public enum View {
      case createTapped
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none

      case .view(.createTapped):
        return .send(.delegate(.createTapped))
      }
    }
  }
}
