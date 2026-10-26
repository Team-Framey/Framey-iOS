import SwiftUI

/// 모서리 반경 토큰입니다. 고정 반경의 단위는 point입니다.
public enum FrameyRadius: Hashable, Sendable {
  /// rounded_sm: 4
  case sm
  /// rounded_md: 6
  case md
  /// rounded_lg: 8
  case lg
  /// rounded_xl: 12
  case xl
  /// rounded_2xl: 16
  case `2xl`
  /// rounded_2_5xl: 20
  case `2.5xl`
  /// rounded_3xl: 24
  case `3xl`
  /// rounded_full: 짧은 변의 절반. 정사각형은 원, 직사각형은 캡슐이 됩니다.
  case full

  public func value(in size: CGSize) -> CGFloat {
    switch self {
    case .sm: 4
    case .md: 6
    case .lg: 8
    case .xl: 12
    case .`2xl`: 16
    case .`2.5xl`: 20
    case .`3xl`: 24
    case .full: max(0, min(size.width, size.height) / 2)
    }
  }
}
