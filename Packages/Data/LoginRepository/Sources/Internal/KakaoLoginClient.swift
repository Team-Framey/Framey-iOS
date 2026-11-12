import DataCore
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import SwiftUI

@DependencyClient
public struct KakaoLoginClient: Sendable {
  public var request: @MainActor @Sendable () async throws -> AuthenticationPhase?
}

extension KakaoLoginClient: DependencyKey {
  public static let liveValue = KakaoLoginClient(
    request: {
      do {
        // TODO: - Kakao 관련 SDK 및 scheme 설정 추가
        let accessToken = try await login()
        throw Unimplemented("Kakao Login API 연결: \(accessToken)")
      } catch {
        if error.isKakaoSignInCancelled {
          return nil
        }
        throw error
      }
    }
  )

  private static func login() async throws -> String {
    return try await withCheckedThrowingContinuation { continuation in
      Task { @MainActor in
        UserApi.shared.loginWithKakaoTalk { token, error in
          if let error {
            if error.isKakaoTalkNotSupported {
              UserApi.shared.loginWithKakaoAccount { token, error in
                if let error {
                  continuation.resume(throwing: error)
                } else {
                  if let token {
                    continuation.resume(returning: token.accessToken)
                  } else {
                    continuation.resume(throwing: Unimplemented("에러 타입 정의"))
                  }
                }
              }
              return
            }
            continuation.resume(throwing: error)
          } else {
            if let token {
              continuation.resume(returning: token.accessToken)
            } else {
              continuation.resume(throwing: Unimplemented("에러 타입 정의"))
            }
          }
        }
      }
    }
  }
}

private extension Error {
  var isKakaoSignInCancelled: Bool {
    guard let kakaoError = self as? SdkError else {
      return false
    }
    switch kakaoError {
    case .ClientFailed(reason: .Cancelled, errorMessage: _),
        .AuthFailed(reason: .AccessDenied, errorInfo: _):
      return true

    default:
      return false
    }
  }

  var isKakaoTalkNotSupported: Bool {
    guard let kakaoError = self as? SdkError else {
      return false
    }
    switch kakaoError {
    case .ClientFailed(reason: .NotSupported, errorMessage: _):
      return true

    default:
      return false
    }
  }
}
