import AuthenticationServices
import Foundation

public struct AppleLoginAuthorization: Sendable {
  public let token: String

  public init(token: String) {
    self.token = token
  }
}

extension AppleLoginAuthorization {
  init(authorization: ASAuthorization) throws {
    guard
      let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
      let identityToken = credential.identityToken,
      let tokenString = String(data: identityToken, encoding: .utf8)
    else {
      // TODO: - 서버 에러 타입 정의
      struct Unimplemented: Error {}
      throw Unimplemented()
    }
    self.token = tokenString
  }
}
