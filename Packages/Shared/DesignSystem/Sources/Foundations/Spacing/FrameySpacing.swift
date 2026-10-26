import SwiftUI

public enum FrameySpacing: Int, Hashable, Sendable {
  case s4 = 4
  case s8 = 8
  case s12 = 12
  case s16 = 16
  case s20 = 20
  case s24 = 24
  case s32 = 32
  case s40 = 40
  case s48 = 48
  case s56 = 56
  case s64 = 64

  public var value: CGFloat {
    CGFloat(rawValue)
  }
}
