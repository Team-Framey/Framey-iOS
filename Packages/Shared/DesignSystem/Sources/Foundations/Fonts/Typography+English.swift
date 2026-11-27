import SwiftUI

extension Typography {
  public static let enM32 = medium(32, letterSpacing: 0)

  public static let enM24 = medium(24, letterSpacing: 0)

  public static let enSB20 = semibold(20)
  public static let enM20 = medium(20)
  public static let enR20 = regular(20)

  public static let enSB18 = semibold(18)
  public static let enM18 = medium(18)
  public static let enR18 = regular(18)

  public static let enM16 = medium(16)
  public static let enM16Tight = medium(16, letterSpacing: -3)
}

extension Typography {
  private static func medium(
    _ size: CGFloat,
    letterSpacing: CGFloat = defaultLetterSpacing
  ) -> Typography {
    Typography(
      font: ResoureKitFontFamily.Poppins.medium.swiftUIFont(size: size),
      size: size,
      letterSpacing: letterSpacing
    )
  }

  private static func regular(
    _ size: CGFloat,
    letterSpacing: CGFloat = defaultLetterSpacing
  ) -> Typography {
    Typography(
      font: ResoureKitFontFamily.Poppins.regular.swiftUIFont(size: size),
      size: size,
      letterSpacing: letterSpacing
    )
  }

  private static func semibold(
    _ size: CGFloat,
    letterSpacing: CGFloat = defaultLetterSpacing
  ) -> Typography {
    Typography(
      font: ResoureKitFontFamily.Poppins.semiBold.swiftUIFont(size: size),
      size: size,
      letterSpacing: letterSpacing
    )
  }
}
