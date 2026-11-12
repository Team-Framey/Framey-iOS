import SwiftUI

extension Typography {
  public static let enM32 = medium(32)

  public static let enM24 = medium(24)

  public static let enSB20 = semibold(20)
  public static let enM20 = medium(20)
  public static let enR20 = regular(20)

  public static let enSB18 = semibold(18)
  public static let enM18 = medium(18)
  public static let enR18 = regular(18)

  public static let enM16 = medium(16)
}

extension Typography {
  private static func medium(_ size: CGFloat) -> Typography {
    Typography(
      font: ResoureKitFontFamily.Poppins.medium.swiftUIFont(size: size)
    )
  }

  private static func regular(_ size: CGFloat) -> Typography {
    Typography(
      font: ResoureKitFontFamily.Poppins.regular.swiftUIFont(size: size)
    )
  }

  private static func semibold(_ size: CGFloat) -> Typography {
    Typography(
      font: ResoureKitFontFamily.Poppins.semiBold.swiftUIFont(size: size)
    )
  }
}
