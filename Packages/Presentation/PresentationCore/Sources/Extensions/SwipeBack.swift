import SwiftUI

extension View {
  public func hideNavigationBar(enableSwipeBack: Bool = true) -> some View {
    self
      .toolbar(.hidden, for: .navigationBar)
      .modifier(SwipeBackModifier(enableSwipeBack: enableSwipeBack))
  }
}

private struct SwipeBackModifier: ViewModifier {
  let enableSwipeBack: Bool

  func body(content: Content) -> some View {
    content
      .background {
        SwipeBackHelper(isEnabled: enableSwipeBack)
      }
  }
}

private struct SwipeBackHelper: UIViewControllerRepresentable {
  let isEnabled: Bool

  func makeUIViewController(context: Context) -> SwipeBackViewController {
    let controller = SwipeBackViewController()
    controller.isSwipeBackEnabled = isEnabled
    return controller
  }

  func updateUIViewController(_ uiViewController: SwipeBackViewController, context: Context) {
    uiViewController.isSwipeBackEnabled = isEnabled
    uiViewController.updateSwipeBackGesture()
  }
}

private class SwipeBackViewController: UIViewController {
  var isSwipeBackEnabled = true

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateSwipeBackGesture()
  }

  func updateSwipeBackGesture() {
    guard
      isViewLoaded,
      let navigationController,
      let topView = navigationController.topViewController?.view,
      view.isDescendant(of: topView)
    else {
      return
    }
    navigationController.interactivePopGestureRecognizer?.isEnabled = isSwipeBackEnabled
    navigationController.interactivePopGestureRecognizer?.delegate = self
  }
}

extension SwipeBackViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    isSwipeBackEnabled && (navigationController?.viewControllers.count ?? 0) > 1
  }
}
