import SwiftUI
import UIKit

@MainActor
final class ModalUIKitAnchor: UIViewController {
  var attachmentChanged: (() -> Void)?

  override func loadView() {
    let view = ModalUIKitAnchorView()
    view.attachmentChanged = { [weak self] in
      self?.attachmentChanged?()
    }
    view.isUserInteractionEnabled = false
    self.view = view
  }
}

@MainActor
private final class ModalUIKitAnchorView: UIView {
  var attachmentChanged: (() -> Void)?

  override func didMoveToWindow() {
    super.didMoveToWindow()
    attachmentChanged?()
  }
}
