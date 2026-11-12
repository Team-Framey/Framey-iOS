import PresentationCore
import SwiftUI

struct SkipLoginButton: View {
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      Text("둘러보기")
        .typography(.bodyR14)
        .foregroundStyle(.framey(.gray500))
        .underline()
    }
    .buttonStyle(.plain)
  }
}
