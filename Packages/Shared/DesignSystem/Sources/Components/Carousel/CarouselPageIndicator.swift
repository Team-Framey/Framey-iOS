import SwiftUI

public struct CarouselPageIndicator: View {
  public struct Configuration: Hashable, Sendable {
    public let height: CGFloat
    public let selectedWidth: CGFloat
    public let spacing: CGFloat
    public let color: FrameyColor
    public let selectedColor: FrameyColor

    public init(
      height: CGFloat = 8,
      selectedWidth: CGFloat = 42,
      spacing: CGFloat = 8,
      color: FrameyColor = .gray300,
      selectedColor: FrameyColor = .gray500
    ) {
      self.height = height
      self.selectedWidth = selectedWidth
      self.spacing = spacing
      self.color = color
      self.selectedColor = selectedColor
    }
  }

  @Binding private var currentIndex: Int
  private let totalCount: Int
  private let configuration: Configuration

  public init(
    configuration: Configuration = .init(),
    currentIndex: Binding<Int>,
    totalCount: Int
  ) {
    precondition(currentIndex.wrappedValue < totalCount && totalCount > 0)
    self.configuration = configuration
    self._currentIndex = currentIndex
    self.totalCount = totalCount
  }

  public var body: some View {
    HStack(spacing: configuration.spacing) {
      ForEach(0..<totalCount, id: \.self) { index in
        let isSelected = currentIndex == index

        Capsule()
          .fill(.framey(isSelected ? configuration.selectedColor : configuration.color))
          .frame(
            width: isSelected ? configuration.selectedWidth : configuration.height,
            height: configuration.height
          )
      }
    }
    .animation(.smooth(duration: 0.3), value: currentIndex)
  }
}
