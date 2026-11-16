import DomainCore
internal import LoginRepository

@DependencyClient
public struct LoginUseCase: Sendable {
  public var appleLoginRequest: @Sendable () async -> AsyncStream<Result<String, Error>> = { .finished }
  public var appleLoginOnCompletion: @Sendable (Result<String, Error>) async throws -> FrameyUser?
  public var googleLoginRequest: @Sendable () async throws -> FrameyUser?
  public var kakaoLoginRequest: @Sendable () async throws -> FrameyUser?
}

extension LoginUseCase: DependencyKey {
  public static let liveValue = LoginUseCase(
    appleLoginRequest: {
      @Dependency(SocialLoginRepository.self) var repository
      return await repository.appleLoginRequest()
        .map {
          switch $0 {
          case let .didCompleteWithAuthorization(authorization):
            return .success(authorization.token)

          case let .didCompleteWithError(error):
            return .failure(error)
          }
        }
        .eraseToStream()
    },
    appleLoginOnCompletion: { result in
      @Dependency(SocialLoginRepository.self) var repository
      switch result {
      case let .success(token):
        return try await repository.appleLoginOnCompletion(.success(.init(token: token)))

      case let .failure(error):
        return try await repository.appleLoginOnCompletion(.failure(error))
      }
    },
    googleLoginRequest: {
      // TODO: - ClientID 추가
      @Dependency(SocialLoginRepository.self) var repository
      return try await repository.googleLoginRequest(clientID: "Client ID 추가")
    },
    kakaoLoginRequest: {
      @Dependency(SocialLoginRepository.self) var repository
      return try await repository.kakaoLoginRequest()
    }
  )

  // TODO: - 로그인 설정 후 제거
  
  public static let mockValue = LoginUseCase(
    appleLoginRequest: {
      return .init { continuation in
        continuation.yield(.success("mock token"))
      }
    },
    appleLoginOnCompletion: { _ in
      return .init(
        email: "apple@apple.com",
        hasSeenOnboarding: false,
        loginType: .apple
      )
    },
    googleLoginRequest: {
      return .init(
        email: "google@google.com",
        hasSeenOnboarding: true,
        loginType: .google
      )
    },
    kakaoLoginRequest: {
      return .init(
        email: "kakao@kakao.com",
        hasSeenOnboarding: false,
        loginType: .kakao
      )
    }
  )
}
