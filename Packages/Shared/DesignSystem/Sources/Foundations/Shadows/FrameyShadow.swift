import SwiftUI

public enum FrameyShadow: Hashable, Sendable {
  /// x: 0, y: 0, blur: 4, color: #007EFF (opacity: 0.08)
  case md
  /// x: -4, y: 0, blur: 20, color: #000000 (opacity: 0.08)
  case md2
  /// x: 0, y: 3, blur: 15, color: #000000 (opacity: 0.1)
  case md3
  /// x: 0, y: 4, blur: 20, color: #000000 (opacity: 0.08)
  case md4

  public var color: Color {
    switch self {
    case .md: .hex(0x007EFF, opacity: 0.08)
    case .md2, .md4: .hex(0x000000, opacity: 0.08)
    case .md3: .hex(0x000000, opacity: 0.1)
    }
  }

  public var x: CGFloat {
    switch self {
    case .md2: -4
    case .md, .md3, .md4: 0
    }
  }

  public var y: CGFloat {
    switch self {
    case .md, .md2: 0
    case .md3: 3
    case .md4: 4
    }
  }

  public var blur: CGFloat {
    switch self {
    case .md: 4
    case .md2, .md4: 20
    case .md3: 15
    }
  }

  /// 피그마와 정확한 값이 아니라 추후 확인 필요함
  public var radius: CGFloat {
    blur / 2
  }
}
