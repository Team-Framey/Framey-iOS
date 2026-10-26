import SwiftUI

public enum FrameyColor: Hashable, Sendable {

  // MARK: - Static

  /// #FFFFFF
  case white
  /// #090A0A
  case black

  // MARK: - Opacity

  /// #090A0A / 10%
  case black10
  /// #090A0A / 70%
  case black70

  // MARK: - Gray

  /// #FCFCFD
  case gray50
  /// #F3F4F6
  case gray100
  /// #E6E7EB
  case gray200
  /// #D2D5DA
  case gray300
  /// #9DA1AC
  case gray400
  /// #747883
  case gray500
  /// #555964
  case gray600
  /// #373B46
  case gray700
  /// #272B36
  case gray800
  /// #181C25
  case gray900

  // MARK: - Primary

  /// #E7F7FF
  case primary100
  /// #C2ECFF
  case primary200
  /// #89DCFF
  case primary300
  /// #4DCCFF
  case primary400
  /// #11B8FF
  case primary500
  /// #0095D6
  case primary600
  /// #0075AD
  case primary700
  /// #005984
  case primary800
  /// #003D5C
  case primary900

  // MARK: - Sub

  /// #FFF4BF
  case yellow

  public var color: Color {
    switch self {
    case .white: .hex(0xFFFFFF)
    case .black: .hex(0x090A0A)
    case .black10: .hex(0x090A0A, opacity: 0.1)
    case .black70: .hex(0x090A0A, opacity: 0.7)
    case .gray50: .hex(0xFCFCFD)
    case .gray100: .hex(0xF3F4F6)
    case .gray200: .hex(0xE6E7EB)
    case .gray300: .hex(0xD2D5DA)
    case .gray400: .hex(0x9DA1AC)
    case .gray500: .hex(0x747883)
    case .gray600: .hex(0x555964)
    case .gray700: .hex(0x373B46)
    case .gray800: .hex(0x272B36)
    case .gray900: .hex(0x181C25)
    case .primary100: .hex(0xE7F7FF)
    case .primary200: .hex(0xC2ECFF)
    case .primary300: .hex(0x89DCFF)
    case .primary400: .hex(0x4DCCFF)
    case .primary500: .hex(0x11B8FF)
    case .primary600: .hex(0x0095D6)
    case .primary700: .hex(0x0075AD)
    case .primary800: .hex(0x005984)
    case .primary900: .hex(0x003D5C)
    case .yellow: .hex(0xFFF4BF)
    }
  }
}
