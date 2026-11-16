import PresentationCore

public enum OnboardingPhase: Int, CaseIterable, Hashable, Sendable {
  case first = 0
  case second
  case third
}

extension OnboardingPhase: Identifiable {
  public var id: OnboardingPhase { self }

  public var index: Int { rawValue }
}

extension OnboardingPhase {
  var next: OnboardingPhase? {
    switch self {
    case .first: .second
    case .second: .third
    case .third: nil
    }
  }

  var previous: OnboardingPhase? {
    switch self {
    case .first: nil
    case .second: .first
    case .third: .second
    }
  }
}
