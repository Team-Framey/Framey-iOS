import PresentationCore

@Reducer
public struct ProfileFeature {
  @ObservableState
  public struct State: Equatable {
    var dialog: Dialog?
    @Shared(.profileNotificationsEnabled) private var storedNotificationPreference
    @SharedReader(.user) var user

    var isNotificationEnabled: Bool {
      get { storedNotificationPreference }
      set { $storedNotificationPreference.withLock { $0 = newValue } }
    }

    var isDialogPresented: Bool {
      get { dialog != nil }
      set {
        if !newValue {
          dialog = nil
        }
      }
    }

    public init() {}
  }

  enum Dialog: Equatable {
    case logout
    case withdrawal
  }

  @CasePathable
  public enum Action: ViewAction {
    case delegate(Delegate)
    case view(View)

    public enum Delegate {
      case loginRequested
      case logoutConfirmed
    }

    public enum View: BindableAction {
      case binding(BindingAction<State>)
      case dialogConfirmTapped
      case dialogDismissed
      case loginTapped
      case logoutTapped
      case withdrawalTapped
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    BindingReducer(action: \.view)
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none

      case .view(.binding):
        return .none

      case .view(.dialogConfirmTapped):
        switch state.dialog {
        case .logout, .withdrawal:
          // TODO: - 회원 탈퇴 API 연결
          state.dialog = nil
          return .send(.delegate(.logoutConfirmed))

        case nil:
          return .none
        }

      case .view(.dialogDismissed):
        state.dialog = nil
        return .none

      case .view(.loginTapped):
        return .send(.delegate(.loginRequested))

      case .view(.logoutTapped):
        state.dialog = .logout
        return .none

      case .view(.withdrawalTapped):
        state.dialog = .withdrawal
        return .none
      }
    }
  }
}
