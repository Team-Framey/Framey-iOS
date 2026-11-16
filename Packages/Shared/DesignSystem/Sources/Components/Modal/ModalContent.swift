import SwiftUI

public struct ModalContent<S: StringProtocol>: View {
  private let content: S

  public init(_ content: S) {
    self.content = content
  }

  public var body: some View {
    Text(content)
      .typography(.bodyR14)
      .foregroundStyle(.framey(.gray700))
      .frame(maxWidth: .infinity, alignment: .center)
      .multilineTextAlignment(.center)
  }
}
