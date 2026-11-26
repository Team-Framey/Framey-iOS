import SwiftUI

public struct Typography: Hashable, Sendable {
  // TODO: - Line Height 반영
  public let font: Font
  public let tracking: CGFloat

  public init(
    font: Font,
    tracking: CGFloat = 0
  ) {
    self.font = font
    self.tracking = tracking
  }
}

extension Typography {
  static let defaultLetterSpacing: CGFloat = -1

  init(
    font: Font,
    size: CGFloat,
    letterSpacing: CGFloat
  ) {
    self.init(font: font, tracking: size * letterSpacing / 100)
  }
}

extension Typography {

  // MARK: - Display

  public static let displaySB36 = semibold(36)
  public static let displaySB32 = semibold(32)
  public static let displaySB28 = semibold(28)

  // MARK: - Title

  public static let titleSB24 = semibold(24)
  public static let titleM24 = medium(24)
  public static let titleSB20 = semibold(20)
  public static let titleM20 = medium(20)
  public static let titleSB18 = semibold(18)
  public static let titleM18 = medium(18)

  // MARK: - Body

  public static let bodySB16 = semibold(16)
  public static let bodyM16 = medium(16)
  public static let bodyM16Tight = medium(16, letterSpacing: -4)
  public static let bodyR16 = regular(16)
  public static let bodySB14 = semibold(14)
  public static let bodyM14 = medium(14)
  public static let bodyR14 = regular(14)

  // MARK: - Caption

  public static let captionSB12 = semibold(12)
  public static let captionM12 = medium(12)
  public static let captionR12 = regular(12)
  public static let captionM10 = medium(10)
}

extension Typography {
  private static func medium(
    _ size: CGFloat,
    letterSpacing: CGFloat = defaultLetterSpacing
  ) -> Typography {
    Typography(
      font: ResoureKitFontFamily.Pretendard.medium.swiftUIFont(size: size),
      size: size,
      letterSpacing: letterSpacing
    )
  }

  private static func regular(
    _ size: CGFloat,
    letterSpacing: CGFloat = defaultLetterSpacing
  ) -> Typography {
    Typography(
      font: ResoureKitFontFamily.Pretendard.regular.swiftUIFont(size: size),
      size: size,
      letterSpacing: letterSpacing
    )
  }

  private static func semibold(
    _ size: CGFloat,
    letterSpacing: CGFloat = defaultLetterSpacing
  ) -> Typography {
    Typography(
      font: ResoureKitFontFamily.Pretendard.semiBold.swiftUIFont(size: size),
      size: size,
      letterSpacing: letterSpacing
    )
  }
}
