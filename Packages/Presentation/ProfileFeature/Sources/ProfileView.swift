import PresentationCore
import SwiftUI

@ViewAction(for: ProfileFeature.self)
public struct ProfileView: View {
  @Bindable public var store: StoreOf<ProfileFeature>

  public init(store: StoreOf<ProfileFeature>) {
    self.store = store
  }

  public var body: some View {
    let dialog = store.dialog
    let user = store.user

    VStack(spacing: .zero) {
      AppBar(center: { AppBarTitle("마이페이지") })

      if let user {
        ScrollView {
          ProfileAccountSection(
            user: user,
            isNotificationEnabled: $store.isNotificationEnabled,
            onLogout: { send(.logoutTapped) },
            onWithdrawal: { send(.withdrawalTapped) }
          )
        }
        .contentMargins(.horizontal, FrameySpacing.s20.value, for: .scrollContent)
        .contentMargins(.top, FrameySpacing.s24.value, for: .scrollContent)
        .contentMargins(.bottom, 96, for: .scrollContent)
      } else {
        ProfileLoginPrompt {
          send(.loginTapped)
        }
        .padding(.horizontal, .s20)
        .padding(.bottom, 96)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.framey(user == nil ? .gray100 : .white))
    .modal(isPresented: $store.isDialogPresented) {
      if let dialog {
        ProfileConfirmationModal(
          dialog: dialog,
          onConfirm: { send(.dialogConfirmTapped) },
          onCancel: { send(.dialogDismissed) }
        )
      }
    }
  }
}
