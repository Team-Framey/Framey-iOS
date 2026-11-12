import Foundation

extension Error {
  public var code: Int {
    return (self as NSError).code
  }

  public var isAppleLoginCancelled: Bool {
    code == 1001
  }
}
