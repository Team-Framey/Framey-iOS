import Foundation

// TODO: - 로그인/회원가입 플로우 추가

public enum AuthenticationPhase: Equatable, Sendable {
  case signInCompleted
  case termsAgreementRequired
}
