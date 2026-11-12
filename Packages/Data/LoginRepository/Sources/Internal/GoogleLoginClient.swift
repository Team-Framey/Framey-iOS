import DataCore
import GoogleSignIn
import SwiftUI

@DependencyClient
public struct GoogleLoginClient: Sendable {
  public var request: @MainActor @Sendable (
    _ clientID: String,
    _ viewController: UIViewController
  ) async throws -> AuthenticationPhase?
}

extension GoogleLoginClient: DependencyKey {
  public static let liveValue = GoogleLoginClient(
    request: { clientID, viewController in
      let configuration = GIDConfiguration(clientID: clientID)
      GIDSignIn.sharedInstance.configuration = configuration
      do {
        // TODO: - Client ID 발급 후 iOS URL scheme 등록
        // Project.swift에 CFBundleURLSchemes 등록 필요 (현재 크래시 발생함)
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: viewController)
        guard let token = result.user.idToken?.tokenString else {
          // TODO: - 서버 에러 타입 정의
          throw Unimplemented("서버 에러 타입 정의")
        }
        // TODO: - API 연결
        throw Unimplemented("Google Login API 연결: \(token), \(result.user.accessToken.tokenString)")
      } catch {
        if error.isGoogleSignInCancelled {
          return nil
        }
        throw error
      }
    }
  )
}
