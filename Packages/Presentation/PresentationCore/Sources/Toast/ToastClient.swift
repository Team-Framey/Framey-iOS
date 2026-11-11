import ComposableArchitecture
import DesignSystem
import SwiftUI
import UIKit

@DependencyClient
public struct ToastClient: Sendable {
  public var show: @Sendable (Toast) -> Void
}

extension ToastClient: DependencyKey {
  public static let liveValue = ToastClient { toast in
    Task { @MainActor in
      Provider.shared.show(toast)
    }
  }

  public func callAsFunction(_ toast: Toast) {
    show(toast)
  }

  public func showSuccess(_ message: String) {
    show(.init(style: .success, delay: .short, message: message))
  }
}

@MainActor
private final class Provider {
  static let shared = Provider()

  private var toastWindow: PassThroughWindow?
  private var dismissTask: Task<Void, Never>?
  private var showTask: Task<Void, Never>?
  private var animator: ToastAnimator?

  func show(_ toast: Toast) {
    guard let windowScene = windowScene() else {
      return
    }
    showTask?.cancel()

    showTask = Task { @MainActor in
      if toastWindow != nil {
        await dismiss()
      }
      if Task.isCancelled {
        return
      }
      await showToast(toast, in: windowScene)
    }
  }

  private func showToast(_ toast: Toast, in windowScene: UIWindowScene) async {
    let window = PassThroughWindow(windowScene: windowScene)
    window.windowLevel = .alert + 1
    window.backgroundColor = .clear

    let animator = ToastAnimator()
    let container = ToastAnimatorContainer(toast: toast, animator: animator)
    let hosting = UIHostingController(rootView: container)
    hosting.view.backgroundColor = .clear

    window.rootViewController = hosting
    window.isHidden = false

    toastWindow = window
    self.animator = animator

    dismissTask = Task { @MainActor in
      @Dependency(\.continuousClock) var clock
      try? await clock.sleep(for: toast.delay.seconds)

      if Task.isCancelled { return }

      await dismiss()
    }
  }

  private func dismiss() async {
    await animator?.dismiss()
    removeCurrentImmediately()
  }

  private func removeCurrentImmediately() {
    dismissTask?.cancel()
    dismissTask = nil

    animator?.isPresented = false
    animator = nil

    toastWindow?.isHidden = true
    toastWindow?.rootViewController = nil
    toastWindow = nil
  }

  private func windowScene() -> UIWindowScene? {
    return UIApplication
      .shared
      .connectedScenes
      .first(
        where: { $0.activationState == .foregroundActive }
      ) as? UIWindowScene
    ?? UIApplication.shared.connectedScenes.first as? UIWindowScene
  }
}

private class PassThroughWindow: UIWindow {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard
      let hitView = super.hitTest(point, with: event),
      hitView != rootViewController?.view
        else {
      return nil
    }
    return hitView
  }
}
