import SwiftUI

public struct ModalHeader<S: StringProtocol>: View {
  private let content: S

  public init(_ content: S) {
    self.content = content
  }

  public var body: some View {
    Text(content)
      .typography(.titleSB18)
      .foregroundStyle(.framey(.gray900))
      .frame(maxWidth: .infinity, alignment: .center)
      .multilineTextAlignment(.center)
  }
}
