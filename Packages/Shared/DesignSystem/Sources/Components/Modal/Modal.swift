import SwiftUI

public struct Modal<Header: View, Content: View, Footer: View>: View {
  public enum ButtonAlignment: Sendable {
    case horizontal
    case vertical
  }

  private let header: Header
  private let content: Content
  private let footer: Footer

  init(
    header: () -> Header,
    content: () -> Content,
    footer: () -> Footer
  ) {
    self.header = header()
    self.content = content()
    self.footer = footer()
  }


  public var body: some View {
    VStack(spacing: .zero) {
      header
        .fixedSize(horizontal: false, vertical: true)

      content
        .fixedSize(horizontal: false, vertical: true)
        .padding(.top, .s8)

      footer
        .fixedSize(horizontal: false, vertical: true)
        .padding(.top, .s24)
        .layoutPriority(1)
    }
    .padding(.top, .s32)
    .padding(.horizontal, .s20)
    .padding(.bottom, .s20)
    .background(.framey(.white))
    .cornerRadius(.`2xl`)
    .shadow(.md4)
  }
}
