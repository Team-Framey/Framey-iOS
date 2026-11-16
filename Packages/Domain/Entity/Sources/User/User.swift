import Foundation

// TODO: - 로그인 후 필요한 정보 채우기
// hasSeenOnboarding: 서버 또는 UserDefaults에서 값 읽어오기

public struct FrameyUser: Hashable, Sendable {
  public var email: String
  public var hasSeenOnboarding: Bool
  public let loginType: LoginType

  public init(
    email: String,
    hasSeenOnboarding: Bool,
    loginType: LoginType
  ) {
    self.email = email
    self.hasSeenOnboarding = hasSeenOnboarding
    self.loginType = loginType
  }
}
