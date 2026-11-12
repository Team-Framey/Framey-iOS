import HomeFeature
import LibraryFeature
import PresentationCore
import ProfileFeature

@Reducer
public struct MainTabFeature {
  @ObservableState
  public struct State: Equatable {
    var current: MainTab
    var home: HomeFeature.State = .init()
    var library: LibraryFeature.State = .init()
    var profile: ProfileFeature.State = .init()

    public init(
      current: MainTab = .home
    ) {
      self.current = current
    }
  }

  @CasePathable
  public enum Action: ViewAction {
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
      return .none
    }
  }
}
