import PresentationCore

@Reducer
public struct CollageCreateFeature {
  @ObservableState
  public struct State: Equatable {
    var isEnabled = false
    var theme: Theme?

    public init() {}
  }

  @CasePathable
  public enum Action: ViewAction {
    case view(View)

    public enum View {
      case closeTapped
      case createTapped
      case themeTapped(Theme)
    }
  }

  @Dependency(\.dismiss) private var dismiss

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(.closeTapped):
        return .run { [dismiss] _ in
          await dismiss()
        }

      case .view(.createTapped):
        return .none

      case let .view(.themeTapped(theme)):
        state.theme = theme
        return .none
      }
    }
  }
}
