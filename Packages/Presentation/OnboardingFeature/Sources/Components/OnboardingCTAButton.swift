import PresentationCore
import SwiftUI

struct OnboardingCTAButton: View {
  let phase: OnboardingPhase
  let action: () -> Void

  public var body: some View {
    Button(action: action) {
      HStack(spacing: .s8) {
        if let icon {
          icon
            .image
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
        }

        Text(title)
      }
      .frame(maxWidth: .infinity)
    }
    .phaseButtonStyle(isLastPhase: isLastPhase)
  }

  private var isLastPhase: Bool {
    phase.next == nil
  }

  private var title: String {
    if isLastPhase {
      return "사진 고르러 가기"
    } else {
      return "다음"
    }
  }

  private var icon: ResoureKitAsset? {
    if isLastPhase {
      return .gallery
    } else {
      return nil
    }
  }
}

private extension View {
  @ViewBuilder
  func phaseButtonStyle(isLastPhase: Bool) -> some View {
    if isLastPhase {
      self.buttonStyle(.frameyPrimary(.large))
    } else {
      self.buttonStyle(.frameyNeutral(.large))
    }
  }
}
