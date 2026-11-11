import PresentationCore

@Reducer
public struct MainTabFeature {
  @ObservableState
  public struct State: Equatable {
    var current: MainTab

    public init(
      current: MainTab = .home
    ) {
      self.current = current
    }
  }

  @CasePathable
  public enum Action: ViewAction {
    case view(View)

    public enum View: BindableAction {
      case binding(BindingAction<State>)
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    BindingReducer(action: \.view)
    Reduce { state, action in
      return .none
    }
  }
}
