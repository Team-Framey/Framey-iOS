import PresentationCore

@Reducer
public struct SplashFeature {
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }

  @CasePathable
  public enum Action: ViewAction {
    case delegate(Delegate)
    case view(View)

    public enum Delegate {
      case completed
    }

    public enum View {
      case task
    }
  }

  @Dependency(\.continuousClock) private var clock

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none

      case .view(.task):
        return .run { [clock] send in
          // TODO: - 가짜 로딩 제거 및 앱 필수 데이터 요청으로 변경
          try? await clock.sleep(for: .seconds(2))
          await send(.delegate(.completed), animation: .smooth)
        }
      }
    }
  }
}
