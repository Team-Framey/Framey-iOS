import PresentationCore

@Reducer
public struct ProfileFeature {
  @ObservableState
  public struct State: Equatable {
    var dialog: Dialog?
    @Shared(.appStorage("profileNotificationsEnabled")) var isNotificationEnabled = true
    @SharedReader(.user) var user

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

    public enum View {
      case dialogConfirmTapped
      case dialogDismissed
      case loginTapped
      case logoutTapped
      case notificationChanged(Bool)
      case withdrawalTapped
    }
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .delegate:
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

      case let .view(.notificationChanged(isEnabled)):
        state.$isNotificationEnabled.withLock { $0 = isEnabled }
        return .none

      case .view(.withdrawalTapped):
        state.dialog = .withdrawal
        return .none
      }
    }
  }
}
