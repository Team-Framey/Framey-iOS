import SwiftUI

public struct ButtonSpinner: View {
  @State private var activeIndex = 0

  private let color: Color
  private let opacity: CGFloat
  private let size: CGSize

  public init(
    color: Color = .white,
    opacity: CGFloat = 0.5,
    size: CGSize = CGSize(width: 8, height: 8)
  ) {
    self.color = color
    self.opacity = opacity
    self.size = size
  }

  public var body: some View {
    HStack(spacing: 6) {
      ForEach(0..<3, id: \.self) { index in
        Circle()
          .fill(color)
          .frame(width: size.width, height: size.height)
          .opacity(activeIndex == index ? 1 : opacity)
          .offset(y: activeIndex == index ? -(size.height + 2) : 0)
      }
    }
    .task {
      while !Task.isCancelled {
        do {
          try await Task.sleep(for: .milliseconds(250))
        } catch {
          return
        }

        withAnimation {
          activeIndex = (activeIndex + 1) % 3
        }
      }
    }
  }
}
