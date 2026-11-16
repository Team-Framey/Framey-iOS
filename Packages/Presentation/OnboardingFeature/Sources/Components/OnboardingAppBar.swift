import PresentationCore
import SwiftUI

@ViewAction(for: OnboardingFeature.self)
struct OnboardingAppBar: View {
  let store: StoreOf<OnboardingFeature>

  var body: some View {
    AppBar(
      leading: {
        AppBarIconButton(icon: .chevronLeft) {
          send(.previousTapped)
        }
        .opacity(store.isPreviousEnabled ? 1 : 0)
        .disabled(!store.isPreviousEnabled)
      },
      trailing: {
        Button {
          send(.skipTapped)
        } label: {
          Text("건너뛰기")
            .typography(.bodyM16)
            .foregroundStyle(.framey(.gray400))
            .padding(.horizontal, .s16)
        }
        .buttonStyle(.plain)
        .opacity(store.isSkipEnabled ? 1 : 0)
        .disabled(!store.isSkipEnabled)
      }
    )
  }
}
