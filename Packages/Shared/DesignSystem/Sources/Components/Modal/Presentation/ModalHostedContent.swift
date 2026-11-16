import SwiftUI

extension EnvironmentValues {
  @Entry var modalPresentation: ModalPresentation? = nil
}

struct ModalHostedContent<Content: View>: View {
  let content: Content
  let presentation: ModalPresentation

  var body: some View {
    content
      .transformEnvironment(\.self) { hostedEnvironment in
        hostedEnvironment.modalPresentation = presentation
      }
  }
}

