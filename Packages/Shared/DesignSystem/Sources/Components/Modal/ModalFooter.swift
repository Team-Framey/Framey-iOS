import SwiftUI

public enum ModalAlignment: Sendable {
  case horizontal
  case vertical
}

public struct ModalFooterContent<Primary: View, Secondary: View> {
  public let primary: Primary
  public let secondary: Secondary?
}

public struct ModalFooter<Primary: View, Secondary: View>: View {
  private let alignment: ModalAlignment
  private let content: ModalFooterContent<Primary, Secondary>

  public init(
    _ alignment: ModalAlignment,
    @ModalFooterBuilder content: () -> ModalFooterContent<Primary, Secondary>
  ) {
    self.alignment = alignment
    self.content = content()
  }

  public var body: some View {
    switch alignment {
    case .horizontal:
      HStack(spacing: .s8) {
        if let secondary = content.secondary {
          secondary
            .buttonStyle(.frameySecondary(.medium))
        }

        primary
      }

    case .vertical:
      VStack(spacing: .s8) {
        primary

        if let secondary = content.secondary {
          secondary
            .typography(.bodyM14)
            .foregroundStyle(.framey(.gray500))
            .underline()
            .buttonStyle(.plain)
        }
      }
    }
  }

  private var primary: some View {
    content.primary
      .buttonStyle(.frameyPrimary(.medium))
  }
}

@resultBuilder
@MainActor
public enum ModalFooterBuilder {
  public static func buildBlock<Primary: View>(
    _ primary: Primary
  ) -> ModalFooterContent<Primary, EmptyView> {
    .init(primary: primary, secondary: nil)
  }

  public static func buildBlock<Primary: View, Secondary: View>(
    _ primary: Primary,
    _ secondary: Secondary
  ) -> ModalFooterContent<Primary, Secondary> {
    .init(primary: primary, secondary: secondary)
  }
}
