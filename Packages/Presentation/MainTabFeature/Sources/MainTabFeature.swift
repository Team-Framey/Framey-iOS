import CollageCreateFeature
import HomeFeature
import LibraryFeature
import PresentationCore
import ProfileFeature

@Reducer
public struct MainTabFeature {
  @Reducer
  public enum Path {
    case collageCreate(CollageCreateFeature)
  }

  @ObservableState
  public struct State: Equatable {
    var current: MainTab
    var home: HomeFeature.State = .init()
    var library: LibraryFeature.State = .init()
    var path: StackState<Path.State> = .init()
    var profile: ProfileFeature.State = .init()

    public init(
      current: MainTab = .home
    ) {
      self.current = current
    }
  }

  @CasePathable
  public enum Action: ViewAction {
    case path(StackActionOf<Path>)
    case tab(Tab)
    case view(View)

    @CasePathable
    public enum Tab {
      case home(HomeFeature.Action)
      case library(LibraryFeature.Action)
      case profile(ProfileFeature.Action)
    }

    public enum View: BindableAction {
      case binding(BindingAction<State>)
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    BindingReducer(action: \.view)
    Scope(\.home, action: \.tab.home) {
      HomeFeature()
    }
    Scope(\.library, action: \.tab.library) {
      LibraryFeature()
    }
    Scope(\.profile, action: \.tab.profile) {
      ProfileFeature()
    }
    Reduce { state, action in
      switch action {
      case .path:
        return .none

      case let .tab(.home(action)):
        return home(&state, action)

      case let .tab(.library(action)):
        return library(&state, action)

      case .tab(.profile):
        return .none

      case .view(.binding):
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }

  private func home(_ state: inout State, _ action: HomeFeature.Action) -> Effect<Action> {
    guard case let .delegate(action) = action else {
      return .none
    }
    switch action {
    case .selectTapped:
      state.path.append(.collageCreate(.init()))
      return .none
    }
  }

  private func library(_ state: inout State, _ action: LibraryFeature.Action) -> Effect<Action> {
    guard case let .delegate(action) = action else {
      return .none
    }
    switch action {
    case .createTapped:
      state.path.append(.collageCreate(.init()))
      return .none
    }
  }
}

extension MainTabFeature.Path.State: Equatable {}
