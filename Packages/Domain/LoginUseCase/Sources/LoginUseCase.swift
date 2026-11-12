import DomainCore
internal import LoginRepository

@DependencyClient
public struct LoginUseCase: Sendable {
  public var appleLoginRequest: @Sendable () async -> AsyncStream<Result<String, Error>> = { .finished }
  public var appleLoginOnCompletion: @Sendable (Result<String, Error>) async throws -> AuthenticationPhase?
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
    }
  )
}
