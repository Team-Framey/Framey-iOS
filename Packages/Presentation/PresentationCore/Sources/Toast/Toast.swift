import Foundation

public struct Toast: Sendable {
  public let style: ToastStyle
  public let delay: ToastDelay
  public let message: String

  public init(
    style: ToastStyle,
    delay: ToastDelay,
    message: String
  ) {
    self.style = style
    self.delay = delay
    self.message = message
  }
}
