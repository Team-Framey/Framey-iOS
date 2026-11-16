import PresentationCore

@Reducer
public struct OnboardingFeature {
  @ObservableState
  public struct State: Equatable {
    var phase: OnboardingPhase
    var isPreviousEnabled: Bool {
      phase.previous != nil
    }
    var isSkipEnabled: Bool {
      phase.next != nil
    }

    public init(
      phase: OnboardingPhase = .first
    ) {
      self.phase = phase
    }
  }

  @CasePathable
  public enum Action: ViewAction {
    case delegate(Delegate)
    case view(View)

    public enum Delegate {
      case onboardingCompleted
    }

    public enum View {
      case nextTapped
      case previousTapped
      case skipTapped
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none

      case .view(.nextTapped):
        guard let next = state.phase.next else {
          return .run { send in
            await send(.delegate(.onboardingCompleted), animation: .smooth)
          }
        }
        state.phase = next
        return .none

      case .view(.previousTapped):
        guard let previous = state.phase.previous else {
          return .none
        }
        state.phase = previous
        return .none

      case .view(.skipTapped):
        return .run { send in
          await send(.delegate(.onboardingCompleted), animation: .smooth)
        }
      }
    }
  }
}
