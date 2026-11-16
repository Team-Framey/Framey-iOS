import PresentationCore
import SwiftUI

@ViewAction(for: OnboardingFeature.self)
public struct OnboardingView: View {
  public let store: StoreOf<OnboardingFeature>

  public init(store: StoreOf<OnboardingFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack(spacing: .zero) {
      OnboardingAppBar(store: store)

      OnboardingContent(store: store)
        .padding(.top, .s8)

      OnboardingCTAButton(phase: store.phase) {
        send(.nextTapped)
      }
      .padding(.top, .s20)
      .padding(.horizontal, .s20)
      .padding(.bottom, .s4)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.framey(.white))
  }
}
