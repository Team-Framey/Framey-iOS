import PresentationCore
import SwiftUI

struct ProfileAccountSection: View {
  let user: FrameyUser
  @Binding var isNotificationEnabled: Bool
  let onLogout: () -> Void
  let onWithdrawal: () -> Void

  var body: some View {
    VStack(alignment: .leading, spacing: .s20) {
      Text("계정")
        .tracking(-0.18)
        .typography(.titleSB18)
        .foregroundStyle(.framey(.gray800))
        .frame(minHeight: 23)
        .accessibilityAddTraits(.isHeader)

      VStack(spacing: .s8) {
        ProfileAccountCard(
          user: user,
          isNotificationEnabled: $isNotificationEnabled,
          onLogout: onLogout
        )

        ProfileWithdrawalButton(action: onWithdrawal)
      }
    }
  }
}

private struct ProfileAccountCard: View {
  let user: FrameyUser
  @Binding var isNotificationEnabled: Bool
  let onLogout: () -> Void

  var body: some View {
    VStack(spacing: .zero) {
      ProfileAccountIdentityRow(user: user)
        .padding(.bottom, .s10)

      separator

      ProfileNotificationToggle(isOn: $isNotificationEnabled)

      separator

      ProfileLogoutButton(action: onLogout)
    }
    .padding(.s12)
    .background(.framey(.gray100))
    .cornerRadius(.`2xl`)
  }

  private var separator: some View {
    Rectangle()
      .fill(.framey(.gray300))
      .frame(height: 1)
      .accessibilityHidden(true)
  }
}

private struct ProfileLogoutButton: View {
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack {
        Text("로그아웃")
          .tracking(-0.64)
          .typography(.bodyM16)
          .foregroundStyle(.framey(.gray900))

        Spacer()

        ResoureKitAsset.chevronRight.image
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
          .accessibilityHidden(true)
      }
      .padding(.vertical, .s10)
      .contentShape(.rect)
    }
    .buttonStyle(.plain)
  }
}

private struct ProfileWithdrawalButton: View {
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      Text("회원 탈퇴")
        .underline()
        .tracking(-0.64)
        .typography(.bodyM16)
        .foregroundStyle(Color.hex(0x4C4C4C))
        .frame(minHeight: 44)
    }
    .buttonStyle(.plain)
  }
}
