import PresentationCore
import SwiftUI

@ViewAction(for: CollageCreateFeature.self)
struct CollageCreateContent: View {
  let store: StoreOf<CollageCreateFeature>

  var body: some View {
    ScrollView {
      VStack(spacing: .s20) {
        CollageCreateSection(title: "사진") {
          ScrollView(.horizontal) {
            HStack(spacing: .s8) {
              // TODO: - 사진 UI 추가
              ForEach(0..<10, id: \.self) { index in
                CollageCreatePhotoRow {
                  // TODO: - Delete
                }
              }
            }
            .padding(.horizontal, .s20)
          }
          .scrollIndicators(.hidden)
          .contentFog(.trailing, .s20)
        }

        CollageCreateSection(
          title: "테마",
          subtitle: "사진에 어울리는 테마를 선택해 보세요!"
        ) {
          VStack(spacing: .s8) {
            ForEach(Theme.allCases) { theme in
              CollageCreateThemeRow(
                theme: theme,
                isSelected: store.theme == theme
              ) {
                send(.themeTapped(theme))
              }
            }
          }
          .padding(.horizontal, .s20)
        }
      }
    }
    .scrollIndicators(.hidden)
    .contentFog(.bottom, .s20)
  }
}
