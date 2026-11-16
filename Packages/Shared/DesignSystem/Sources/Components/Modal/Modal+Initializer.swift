import SwiftUI

extension Modal {
  public init<Title: StringProtocol, Description: StringProtocol, Primary: View, Secondary: View>(
    _ alignment: ModalAlignment = .horizontal,
    title: Title,
    description: Description,
    @ModalFooterBuilder actions: () -> ModalFooterContent<Primary, Secondary>
  ) where Header == ModalHeader<Title>, Content == ModalContent<Description>, Footer == ModalFooter<Primary, Secondary> {
    self.init(
      header: { ModalHeader(title) },
      content: { ModalContent(description) },
      footer: {
        ModalFooter(alignment, content: actions)
      }
    )
  }

  public init<Title: StringProtocol, Primary: View, Secondary: View>(
    _ alignment: ModalAlignment = .horizontal,
    title: Title,
    @ModalFooterBuilder actions: () -> ModalFooterContent<Primary, Secondary>
  ) where Header == ModalHeader<Title>, Content == EmptyView, Footer == ModalFooter<Primary, Secondary> {
    self.init(
      header: { ModalHeader(title) },
      content: { EmptyView() },
      footer: {
        ModalFooter(alignment, content: actions)
      }
    )
  }
}
