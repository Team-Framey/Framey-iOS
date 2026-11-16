import PresentationCore
import SwiftUI

@ViewAction(for: OnboardingFeature.self)
struct OnboardingContent: View {
  let store: StoreOf<OnboardingFeature>

  var body: some View {
    VStack(spacing: .zero) {
      ScrollViewReader { proxy in
        ScrollView(.horizontal) {
          HStack(spacing: .zero) {
            ForEach(OnboardingPhase.allCases) { phase in
              OnboardingPhaseContent(phase: phase)
                .frame(width: UIScreen.main.bounds.width)
            }
          }
        }
        .scrollDisabled(true)
        .scrollIndicators(.hidden)
        .onChange(of: store.phase, initial: true) { _, phase in
          withAnimation {
            proxy.scrollTo(phase, anchor: .leading)
          }
        }
      }

      CarouselPageIndicator(
        currentIndex: store.phase.index,
        totalCount: OnboardingPhase.allCases.count
      )
    }
  }
}

struct OnboardingPhaseContent: View {
  let phase: OnboardingPhase

  var body: some View {
    VStack(
      alignment: .leading,
      spacing: .zero
    ) {
      icon

      Text(title)
        .typography(.displaySB32)
        .foregroundStyle(.framey(.gray900))
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
        .padding(.top, .s16)

      Text(subtitle)
        .typography(.bodyM16)
        .foregroundStyle(.framey(.gray600))
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
        .padding(.top, .s10)

      Spacer()

      // TODO: - 온보딩 이미지 추가
      FrameyRoundedShape(token: .`2.5xl`)
        .fill(.framey(.primary100))
        .aspectRatio(353 / 314, contentMode: .fit)

      Spacer()
    }
    .padding(.horizontal, .s20)
  }

  @ViewBuilder
  private var icon: some View {
    switch phase {
    case .first:
      ResoureKitAsset.appLogoFillSmall.image
        .resizable()
        .scaledToFit()
        .frame(width: 50, height: 50)

    case .second:
      Text("HOW IT")
        .typography(.enM20)
        .foregroundStyle(.framey(.primary500))
        .frame(height: 50, alignment: .leading)

    case .third:
      Text("READY")
        .typography(.enM20)
        .foregroundStyle(.framey(.primary500))
        .frame(height: 50, alignment: .leading)
    }
  }

  private var title: String {
    switch phase {
    case .first: "사진만 고르면,\n스토리는 끝"
    case .second: "세 번이면 끝나요"
    case .third: "첫 콜라주를\n만들어볼까요?"
    }
  }

  private var subtitle: String {
    switch phase {
    case .first: "배치도 프레임도 고민하지 마세요.\nFramey로 쉽게 완성하세요."
    case .second: "복잡한 편집이나 고민 없이\n사진과 테마만 고르고, 바로 공유하면 돼요."
    case .third: "어떤 사진이어도 괜찮아요.\n마음에 드는 사진 몇 장만 골라주세요."
    }
  }
}
