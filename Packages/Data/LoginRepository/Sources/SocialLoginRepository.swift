import AuthenticationServices
import DataCore
import UIKit

@DependencyClient
public struct SocialLoginRepository: Sendable {
  public var appleLoginRequest: @Sendable () async -> AsyncStream<AppleLoginAction> = { .finished }
  public var appleLoginOnCompletion: @Sendable (Result<AppleLoginAuthorization, Error>) async throws -> AuthenticationPhase?
}

extension SocialLoginRepository: DependencyKey {
  public static let liveValue = SocialLoginRepository(
    appleLoginRequest: {
      @Dependency(AppleLoginClient.self) var client
      return await client.request()
    },
    appleLoginOnCompletion: { result in
      @Dependency(AppleLoginClient.self) var client
      return try await client.onCompletion(result)
    }
  )
}
