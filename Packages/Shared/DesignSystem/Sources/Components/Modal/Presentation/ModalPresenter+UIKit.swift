import SwiftUI
import UIKit

struct ModalPresenter<Content: View>: UIViewControllerRepresentable {
  @Binding var isPresented: Bool
  let dismissOnBackgroundTap: Bool
  let onDismiss: (() -> Void)?
  let content: () -> Content

  func makeCoordinator() -> ModalUIKitCoordinator<Content> {
    ModalUIKitCoordinator()
  }

  func makeUIViewController(
    context: Context
  ) -> ModalUIKitAnchor {
    let anchor = ModalUIKitAnchor()
    context.coordinator.anchor = anchor
    anchor.attachmentChanged = { [weak coordinator = context.coordinator] in
      coordinator?.scheduleUpdate()
    }
    return anchor
  }

  func updateUIViewController(
    _ controller: ModalUIKitAnchor,
    context: Context
  ) {
    context.coordinator.update(
      binding: $isPresented,
      dismissOnBackgroundTap: dismissOnBackgroundTap,
      onDismiss: onDismiss,
      content: isPresented ? content() : nil,
      environment: context.environment
    )
  }

  static func dismantleUIViewController(
    _ controller: ModalUIKitAnchor,
    coordinator: ModalUIKitCoordinator<Content>
  ) {
    controller.attachmentChanged = nil
    DispatchQueue.main.async {
      coordinator.presentation.invalidate()
    }
  }
}
