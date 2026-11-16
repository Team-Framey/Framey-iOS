import PresentationCore
import SwiftUI

struct CollageCreatePhotoRow: View {
  let delete: () -> Void

  var body: some View {
    CheckerboardShape(squareSize: 10)
      .fill(Color.hex(0xFAFAFA))
      .background(Color.hex(0xEBEBEB))
      .frame(width: 108, height: 151)
      .cornerRadius(.xl)
      .overlay(alignment: .topTrailing) {
        Button(action: delete) {
          ResoureKitAsset.deleteCircleFill.image
            .resizable()
            .frame(width: 24, height: 24)
            .opacity(0.5)
        }
        .buttonStyle(.plain)
        .padding(.top, .s10)
        .padding(.trailing, .s8)
      }
  }
}
