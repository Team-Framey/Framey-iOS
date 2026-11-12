import SwiftUI

extension UIApplication {
  @MainActor
  var firstKeyWindow: UIWindow? {
    connectedScenes.compactMap { $0 as? UIWindowScene }
      .flatMap(\.windows)
      .first(where: \.isKeyWindow)
  }

  @MainActor
  var rootViewController: UIViewController? {
    firstKeyWindow?.rootViewController
  }
}
