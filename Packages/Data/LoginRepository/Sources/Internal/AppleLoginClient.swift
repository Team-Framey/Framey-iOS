import AuthenticationServices
import DataCore

@DependencyClient
struct AppleLoginClient: Sendable {
  var request: @Sendable @MainActor () async -> AsyncStream<AppleLoginAction> = { .finished }
  var onCompletion: @Sendable (Result<AppleLoginAuthorization, Error>) async throws -> AuthenticationPhase?
}

extension AppleLoginClient: DependencyKey {
  static let liveValue = AppleLoginClient(
    request: {
      let requestID = UUID()
      let provider = ASAuthorizationAppleIDProvider()
      let request = provider.createRequest()
      let nonce = await AppleLoginProvider.shared.requestSHA256Nonce()
      request.requestedScopes = [.fullName, .email]
      request.nonce = nonce
      let delegate = AppleLoginDelegate()
      var continuation: AsyncStream<AppleLoginAction>.Continuation!
      let controller = ASAuthorizationController(
        authorizationRequests: [request]
      )
      let stream = AsyncStream<AppleLoginAction> {
        $0.onTermination = { _ in
          Task {
            await AppleLoginProvider.shared.removeDelegate(for: requestID)
          }
        }
        continuation = $0
      }
      delegate.continuation = continuation
      await AppleLoginProvider.shared.setDelegate(delegate, for: requestID)
      controller.delegate = delegate
      controller.presentationContextProvider = delegate
      controller.performRequests()
      return stream
    },
    onCompletion: { result in
      switch result {
      case let .success(authorization):
        throw Unimplemented("Apple Login API 연결: \(authorization.token)")

      case let .failure(error):
        if error.isAppleLoginCancelled {
          return nil
        }
        throw error
      }
    }
  )
}
