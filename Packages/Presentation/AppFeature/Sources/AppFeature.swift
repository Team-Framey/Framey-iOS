import LoginFeature
import MainTabFeature
import PresentationCore
import SplashFeature

@Reducer
public struct AppFeature {
  @Reducer
  public enum Content {
    case login(LoginFeature)
    case mainTab(MainTabFeature)
    case splash(SplashFeature)
  }

  @ObservableState
  public struct State: Equatable {
    var content: Content.State

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
    case .signInCompleted:
      state.content = .mainTab(.init())
      return .none
    }
  }

  private func mainTab(_ state: inout State, _ action: MainTabFeature.Action) -> Effect<Action> {
    // TODO: - MainTab Delegate Action 처리
    return .none
  }

  private func splash(_ state: inout State, _ action: SplashFeature.Action) -> Effect<Action> {
    guard case let .delegate(action) = action else {
      return .none
    }
    switch action {
    case .completed:
      // TODO: - 인증 여부에 따라 Login/MainTab 으로 전환
      state.content = .login(.init())
      return .none
    }
  }
}

extension AppFeature.Content.State: Equatable {}
