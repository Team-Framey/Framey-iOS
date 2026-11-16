import LoginFeature
import MainTabFeature
import OnboardingFeature
import PresentationCore
import SplashFeature

@Reducer
public struct AppFeature {
  @Reducer
  public enum Content {
    case login(LoginFeature)
    case mainTab(MainTabFeature)
    case onboarding(OnboardingFeature)
    case splash(SplashFeature)
  }

  @ObservableState
  public struct State: Equatable {
    var content: Content.State
    @Shared(.user) var user

    public init(
      content: Content.State = .splash(.init())
    ) {
      self.content = content
    }
  }

  @CasePathable
  public enum Action {
    case content(Content.Action)
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Scope(\.content, action: \.content) {
      Content.body
    }
    Reduce { state, action in
      switch action {
      case let .content(.login(action)):
        return login(&state, action)

      case let .content(.mainTab(action)):
        return mainTab(&state, action)

      case let .content(.onboarding(action)):
        return onboarding(&state, action)

      case let .content(.splash(action)):
        return splash(&state, action)
      }
    }
  }

  private func login(_ state: inout State, _ action: LoginFeature.Action) -> Effect<Action> {
    guard case let .delegate(action) = action else {
      return .none
    }
    switch action {
    case let .signInCompleted(user):
      return userReceived(&state, user: user)

    case .signInSkipped:
      state.content = .mainTab(.init())
      return .none
    }
  }

  private func mainTab(_ state: inout State, _ action: MainTabFeature.Action) -> Effect<Action> {
    // TODO: - MainTab Delegate Action 처리
    return .none
  }

  private func onboarding(_ state: inout State, _ action: OnboardingFeature.Action) -> Effect<Action> {
    guard case let .delegate(action) = action else {
      return .none
    }
    switch action {
    case .onboardingCompleted:
      // TODO: - 필요 시 API 또는 UserDefaults 저장
      state.$user.withLock {
        $0?.hasSeenOnboarding = true
      }
      state.content = .mainTab(.init())
      return .none
    }
  }

  private func splash(_ state: inout State, _ action: SplashFeature.Action) -> Effect<Action> {
    guard case let .delegate(action) = action else {
      return .none
    }
    switch action {
    case let .completed(user):
      guard let user else {
        state.content = .login(.init())
        return .none
      }
      return userReceived(&state, user: user)
    }
  }

  private func userReceived(_ state: inout State, user: FrameyUser) -> Effect<Action> {
    state.$user.withLock {
      $0 = user
    }

    if user.hasSeenOnboarding {
      state.content = .mainTab(.init())
    } else {
      state.content = .onboarding(.init())
    }
    return .none
  }
}

extension AppFeature.Content.State: Equatable {}
