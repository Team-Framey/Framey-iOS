import PresentationCore

@Reducer
public struct LibraryFeature {
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }

  @CasePathable
  public enum Action: ViewAction {
    case view(View)

    public enum View {}
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
  }
}
