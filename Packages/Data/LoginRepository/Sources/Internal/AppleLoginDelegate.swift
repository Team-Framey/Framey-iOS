import AuthenticationServices
import CryptoKit
import DataCore
import SwiftUI

final class AppleLoginDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
  var continuation: AsyncStream<AppleLoginAction>.Continuation?

  func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithAuthorization authorization: ASAuthorization
  ) {
    do {
      let authorization = try AppleLoginAuthorization(authorization: authorization)
      continuation?.yield(.didCompleteWithAuthorization(authorization))
    } catch {
      continuation?.yield(.didCompleteWithError(error))
    }

    continuation?.finish()
  }

  func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithError error: any Error
  ) {
    continuation?.yield(.didCompleteWithError(error))
    continuation?.finish()
  }

  func presentationAnchor(
    for controller: ASAuthorizationController
  ) -> ASPresentationAnchor {
    return UIApplication.shared.firstKeyWindow ?? .init()
  }
}
