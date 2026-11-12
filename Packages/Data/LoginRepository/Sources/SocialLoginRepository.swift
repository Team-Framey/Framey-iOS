import AuthenticationServices
import DataCore
import UIKit

@DependencyClient
public struct SocialLoginRepository: Sendable {
  public var appleLoginRequest: @Sendable () async -> AsyncStream<AppleLoginAction> = { .finished }
  public var appleLoginOnCompletion: @Sendable (Result<AppleLoginAuthorization, Error>) async throws -> AuthenticationPhase?
  public var googleLoginRequest: @Sendable (_ clientID: String) async throws -> AuthenticationPhase?
  public var kakaoLoginRequest: @Sendable () async throws -> AuthenticationPhase?
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
    },
    googleLoginRequest: { clientID in
      @Dependency(GoogleLoginClient.self) var client
      guard let viewController = await UIApplication.shared.rootViewController else {
        // TODO: - 에러 타입 추가
        throw Unimplemented("에러 케이스 추가")
      }
      return try await client.request(clientID: clientID, viewController: viewController)
    },
    kakaoLoginRequest: {
      @Dependency(KakaoLoginClient.self) var clinet
      return try await clinet.request()
    }
  )
}
