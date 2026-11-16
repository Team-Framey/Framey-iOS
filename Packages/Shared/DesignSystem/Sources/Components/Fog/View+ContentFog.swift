import SwiftUI

extension View {
  public func contentFog(
    _ variant: ContentFogVariant = .bottom,
    color: Color = .framey(.white),
    fraction: CGFloat = 0.2
  ) -> some View {
    modifier(
      ContentFogModifier(
        color: color,
        variant: variant,
        size: .fraction(fraction)
      )
    )
  }

  public func contentFog(
    _ variant: ContentFogVariant = .bottom,
    color: Color = .framey(.white),
    size: CGFloat
  ) -> some View {
    modifier(
      ContentFogModifier(
        color: color,
        variant: variant,
        size: .fixed(size)
      )
    )
  }

  public func contentFog(
    _ variant: ContentFogVariant = .bottom,
    _ spacing: FrameySpacing,
    color: Color = .framey(.white),
  ) -> some View {
    modifier(
      ContentFogModifier(
        color: color,
        variant: variant,
        size: .fixed(spacing.value)
      )
    )
  }
}

public enum ContentFogVariant: CaseIterable, Hashable, Sendable {
  case top
  case bottom
  case leading
  case trailing
}

public enum ContentFogSize: Hashable, Sendable {
  case fixed(CGFloat)
  case fraction(CGFloat)
}

private struct ContentFogModifier: ViewModifier {
  private let color: Color
  private let variant: ContentFogVariant
  private let size: ContentFogSize

  public init(
    color: Color,
    variant: ContentFogVariant,
    size: ContentFogSize
  ) {
    self.color = color
    self.variant = variant
    self.size = size
  }

  func body(content: Content) -> some View {
    content
      .overlay {
        GeometryReader { proxy in
          switch variant {
          case .top, .bottom:
            VStack(spacing: .zero) {
              if variant == .top {
                ContentFog(direction: .down, color: color)
                  .frame(height: size(proxy.size.height))
              }

              Spacer()

              if variant == .bottom {
                ContentFog(direction: .up, color: color)
                  .frame(height: size(proxy.size.height))
              }
            }

          case .leading, .trailing:
            HStack(spacing: .zero) {
              if variant == .leading {
                ContentFog(direction: .trailing, color: color)
                  .frame(width: size(proxy.size.width))
              }

              Spacer()

              if variant == .trailing {
                ContentFog(direction: .leading, color: color)
                  .frame(width: size(proxy.size.width))
              }
            }
          }
        }
      }
  }

  private func size(_ proxySize: CGFloat) -> CGFloat {
    switch size {
    case let .fixed(size): size
    case let .fraction(fraction): proxySize * fraction
    }
  }
}
