import SwiftUI
import UIKit

@MainActor
final class ModalUIKitCoordinator<Content: View>: NSObject, UIViewControllerTransitioningDelegate
{
  weak var anchor: ModalUIKitAnchor?

  private var binding: Binding<Bool> = .constant(false)
  private var dismissOnBackgroundTap = false
  private var onDismiss: (() -> Void)?
  private var content: Content?
  private var environment = EnvironmentValues()
  private var dialog: ModalUIKitController<Content>?
  private var presenter: UIViewController?
  private var updateScheduled = false
  private var previousFocus: Any?

  lazy var presentation = ModalPresentation(
    present: { [weak self] in
      self?.present() ?? false
    },
    dismiss: { [weak self] in
      self?.dismiss()
    }
  )

  func update(
    binding: Binding<Bool>,
    dismissOnBackgroundTap: Bool,
    onDismiss: (() -> Void)?,
    content: Content?,
    environment: EnvironmentValues
  ) {
    self.binding = binding
    self.dismissOnBackgroundTap = dismissOnBackgroundTap
    self.onDismiss = onDismiss
    if let content {
      self.content = content
    }
    self.environment = environment
    if let dialog {
      if presentation.canUpdatePresentedContent, let hostedContent {
        dialog.rootView = hostedContent
      }
      dialog.overrideUserInterfaceStyle = environment.colorScheme == .dark ? .dark : .light
      if let controller = dialog.presentationController as? ModalUIKitPresentationController<Content> {
        controller.update(environment: environment)
      }
    }
    scheduleUpdate()
  }

  func scheduleUpdate() {
    guard !updateScheduled else {
      return
    }
    updateScheduled = true
    DispatchQueue.main.async { [weak self] in
      guard let self else {
        return
      }
      self.updateScheduled = false
      let isReady = self.anchor?.viewIfLoaded?.window != nil
      self.presentation.update(
        isPresented: self.binding,
        onDismiss: self.onDismiss,
        isReady: isReady
      )
      if !isReady {
        self.presentation.requestDismissal()
      }
    }
  }

  private var hostedContent: ModalHostedContent<Content>? {
    content.map {
      ModalHostedContent(
        content: $0,
        presentation: presentation
      )
    }
  }

  private func present() -> Bool {
    guard let hostedContent, let anchor, anchor.viewIfLoaded?.window != nil else {
      return false
    }
    var controller: UIViewController = anchor
    while let parent = controller.parent {
      controller = parent
    }
    while let presented = controller.presentedViewController {
      controller = presented
    }
    if controller.isBeingPresented || controller.isBeingDismissed {
      controller.transitionCoordinator?.animate(alongsideTransition: nil) { [weak self] _ in
        self?.scheduleUpdate()
      }
      return false
    }
    previousFocus = UIAccessibility.focusedElement(using: .notificationVoiceOver)
    let dialog = ModalUIKitController(rootView: hostedContent)
    dialog.owner = self
    dialog.modalPresentationStyle = .custom
    dialog.transitioningDelegate = self
    dialog.isModalInPresentation = true
    dialog.overrideUserInterfaceStyle = environment.colorScheme == .dark ? .dark : .light
    dialog.view.backgroundColor = .clear
    dialog.view.accessibilityViewIsModal = true
    self.dialog = dialog
    self.presenter = controller
    controller.present(dialog, animated: true) { [weak self, weak dialog] in
      guard let self, let dialog, self.dialog === dialog else {
        return
      }
      self.presentation.presentationDidFinish()
    }
    return true
  }

  private func dismiss() {
    guard let dialog, dialog.presentingViewController != nil else {
      dismissalDidFinish()
      return
    }
    dialog.view.isUserInteractionEnabled = false
    dialog.dismiss(animated: true) { [self] in
      guard self.dialog === dialog else {
        return
      }
      dismissalDidFinish()
    }
  }

  func dismissalDidFinish() {
    guard dialog != nil else {
      return
    }
    dialog?.owner = nil
    dialog = nil
    presenter = nil
    UIAccessibility.post(notification: .screenChanged, argument: previousFocus)
    previousFocus = nil
    presentation.dismissalDidFinish()
  }

  func presentationController(
    forPresented presented: UIViewController,
    presenting: UIViewController?,
    source: UIViewController
  ) -> UIPresentationController? {
    ModalUIKitPresentationController<Content>(
      presentedViewController: presented,
      presenting: presenting,
      environment: environment,
      onBackgroundTap: { [weak self] in
        guard let self, self.dismissOnBackgroundTap else {
          return
        }
        self.presentation.requestDismissal()
      }
    )
  }

  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> (any UIViewControllerAnimatedTransitioning)? {
    ModalUIKitAnimator(
      isPresenting: true
    )
  }

  func animationController(
    forDismissed dismissed: UIViewController
  ) -> (any UIViewControllerAnimatedTransitioning)? {
    ModalUIKitAnimator(
      isPresenting: false
    )
  }
}

// MARK: - ModalUIKitController

private final class ModalUIKitController<Content: View>: UIHostingController<ModalHostedContent<Content>> {
  var owner: ModalUIKitCoordinator<Content>?

  override var canBecomeFirstResponder: Bool { true }
  override var keyCommands: [UIKeyCommand]? {
    [
      UIKeyCommand(
        input: UIKeyCommand.inputEscape,
        modifierFlags: [],
        action: #selector(escapePressed)
      )
    ]
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    becomeFirstResponder()
    UIAccessibility.post(
      notification: .screenChanged,
      argument: view
    )
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    if owner?.presentation.phase != .dismissing, presentingViewController == nil {
      owner?.presentation.presentationDidFinish()
      owner?.presentation.requestDismissal()
    }
  }

  override func accessibilityPerformEscape() -> Bool {
    owner?.presentation.requestDismissal() ?? false
  }

  @objc private func escapePressed() {
    owner?.presentation.requestDismissal()
  }
}

// MARK: - ModalUIKitPresentationController

private final class ModalUIKitPresentationController<Content: View>: UIPresentationController {
  private let dimmer = UIView()
  private let onBackgroundTap: () -> Void
  private var environment: EnvironmentValues

  init(
    presentedViewController: UIViewController,
    presenting: UIViewController?,
    environment: EnvironmentValues,
    onBackgroundTap: @escaping () -> Void
  ) {
    self.environment = environment
    self.onBackgroundTap = onBackgroundTap
    super.init(presentedViewController: presentedViewController, presenting: presenting)
    dimmer.isAccessibilityElement = false
    dimmer.addGestureRecognizer(
      UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
    )
    update(environment: environment)
  }

  @objc private func backgroundTapped() {
    onBackgroundTap()
  }

  func update(environment: EnvironmentValues) {
    self.environment = environment
    dimmer.backgroundColor = FrameyColor.black40.uiColor
    dimmer.overrideUserInterfaceStyle = environment.colorScheme == .dark ? .dark : .light
    containerView?.setNeedsLayout()
  }

  override var frameOfPresentedViewInContainerView: CGRect {
    guard
      let containerView,
      let host = presentedViewController as? ModalUIKitController<Content>
        else {
      return .zero
    }
    return Metric.cardFrame(
      in: containerView.safeAreaLayoutGuide.layoutFrame
    ) {
      host.sizeThatFits(in: $0)
    }
  }

  override func containerViewWillLayoutSubviews() {
    super.containerViewWillLayoutSubviews()
    dimmer.frame = containerView?.bounds ?? .zero
    presentedView?.frame = frameOfPresentedViewInContainerView
  }

  override func presentationTransitionWillBegin() {
    guard let containerView else {
      return
    }
    dimmer.frame = containerView.bounds
    dimmer.alpha = 0
    containerView.insertSubview(dimmer, at: 0)
    UIView.animate(withDuration: 0.2) {
      self.dimmer.alpha = 1
    }
  }

  override func presentationTransitionDidEnd(_ completed: Bool) {
    if !completed {
      dimmer.removeFromSuperview()
    }
  }

  override func dismissalTransitionWillBegin() {
    UIView.animate(withDuration: 0.2) {
      self.dimmer.alpha = 0
    }
  }

  override func dismissalTransitionDidEnd(_ completed: Bool) {
    if completed {
      dimmer.removeFromSuperview()
    }
  }

  override func adaptivePresentationStyle(
    for traitCollection: UITraitCollection
  ) -> UIModalPresentationStyle {
    .none
  }
}

// MARK: - ModalUIKitAnimator

private final class ModalUIKitAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  let isPresenting: Bool

  init(isPresenting: Bool) {
    self.isPresenting = isPresenting
  }

  func transitionDuration(
    using transitionContext: (any UIViewControllerContextTransitioning)?
  ) -> TimeInterval {
    isPresenting ? 0.3 : 0.2
  }

  func animateTransition(
    using context: any UIViewControllerContextTransitioning
  ) {
    let key: UITransitionContextViewControllerKey = isPresenting ? .to : .from
    guard
      let controller = context.viewController(forKey: key),
      let view = context.view(forKey: isPresenting ? .to : .from)
        else {
      context.completeTransition(false)
      return
    }
    let offset = CGAffineTransform(
      translationX: 0,
      y: Metric.travel
    )
    if isPresenting {
      view.frame = context.finalFrame(for: controller)
      context.containerView.addSubview(view)
      view.alpha = 0
      view.transform = offset
    }
    UIView.animate(
      withDuration: transitionDuration(using: context),
      delay: 0,
      options: [isPresenting ? .curveEaseOut : .curveEaseIn, .beginFromCurrentState]
    ) {
      view.alpha = self.isPresenting ? 1 : 0
      view.transform = self.isPresenting ? .identity : offset
    } completion: { _ in
      let completed = !context.transitionWasCancelled
      if !self.isPresenting, completed {
        view.removeFromSuperview()
      }
      view.transform = .identity
      context.completeTransition(completed)
    }
  }
}

// MARK: - Metric

private enum Metric {
  static let horizontalMargin: CGFloat = 30
  static let verticalMargin: CGFloat = 24
  static let travel: CGFloat = 24

  static func cardFrame(in bounds: CGRect, fittingSize: (CGSize) -> CGSize) -> CGRect {
    let available = bounds.insetBy(dx: horizontalMargin, dy: verticalMargin)
    let width = max(0, available.width)
    let maximumHeight = max(0, available.height)
    let size = fittingSize(.init(width: width, height: maximumHeight))
    let height = max(0, min(size.height, maximumHeight))
    return .init(
      x: bounds.midX - width / 2,
      y: bounds.midY - height / 2,
      width: width,
      height: height
    )
  }
}
