import SwiftUI

extension ButtonStyle where Self == FrameyPrimaryButtonStyle {
  /// 기본 Medium 사이즈
  public static var frameyPrimary: FrameyPrimaryButtonStyle {
    frameyPrimary(.medium)
  }

  public static func frameyPrimary(_ size: FrameyButtonSize) -> FrameyPrimaryButtonStyle {
    .init(size: size)
  }
}

extension ButtonStyle where Self == FrameySecondaryButtonStyle {
  /// 기본 Medium 사이즈
  public static var frameySecondary: FrameySecondaryButtonStyle {
    frameySecondary(.medium)
  }

  public static func frameySecondary(_ size: FrameyButtonSize) -> FrameySecondaryButtonStyle {
    .init(size: size)
  }
}

extension ButtonStyle where Self == FrameyNeutralButtonStyle {
  /// 기본 Medium 사이즈
  public static var frameyNeutral: FrameyNeutralButtonStyle {
    frameyNeutral(.medium)
  }

  public static func frameyNeutral(_ size: FrameyButtonSize) -> FrameyNeutralButtonStyle {
    .init(size: size)
  }
}
