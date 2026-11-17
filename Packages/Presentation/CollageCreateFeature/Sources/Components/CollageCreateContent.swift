import PhotosUI
import PresentationCore
import SwiftUI

@ViewAction(for: CollageCreateFeature.self)
struct CollageCreateContent: View {
  @Bindable var store: StoreOf<CollageCreateFeature>

  var body: some View {
    ScrollView {
      VStack(spacing: .s20) {
        CollageCreateSection(title: "사진") {
          ScrollView(.horizontal) {
            HStack(spacing: .s8) {
              CollageCreatePhotoAddButton(
                count: store.photoItems.count,
                totalCount: store.maximumPhotoCount
              ) {
                send(.addTapped)
              }

              ForEach(store.selectedPhotos) { photo in
                CollageCreatePhotoRow(photo: photo) {
                  send(.photoDeleteTapped(photo.item))
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
              CollageThemeRow(
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
    .photosPicker(
      isPresented: $store.isPhotoPickerPresented,
      selection: $store.photoItems,
      maxSelectionCount: store.maximumPhotoCount,
      matching: .images
    )
  }
}
