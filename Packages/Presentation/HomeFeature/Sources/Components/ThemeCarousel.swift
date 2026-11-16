import PresentationCore
import SwiftUI

struct ThemeCarousel: View {
  @State private var position = Double(Theme.allCases.firstIndex(of: .default) ?? 0)
  @State private var dragStart: Double?

  var body: some View {
    CarouselContent(position: position) { index in
      withAnimation(.spring(duration: 0.4, bounce: 0.15)) { position = Double(index) }
    }
    .frame(maxWidth: .infinity, alignment: .top)
    .frame(height: Metric.height, alignment: .top)
    .contentShape(.rect)
    .gesture(
      DragGesture(minimumDistance: 8)
        .onChanged { value in
          let start = dragStart ?? position
          dragStart = start
          position = start - value.translation.width / Metric.spacing
        }
        .onEnded { value in
          let start = dragStart ?? position
          dragStart = nil
          let predicted = start - value.predictedEndTranslation.width / Metric.spacing
          let target = min(max(predicted.rounded(), start.rounded() - 1), start.rounded() + 1)
          withAnimation(.spring(duration: 0.4, bounce: 0.15)) { position = target }
        }
    )
    .sensoryFeedback(.selection, trigger: Int(position.rounded()))
  }
}

// MARK: - CarouselContent

private struct CarouselContent: View, Animatable {
  var position: Double
  var onSelect: (Int) -> Void

  nonisolated var animatableData: Double {
    get { position }
    set { position = newValue }
  }

  var body: some View {
    let center = Int(position.rounded())
    ZStack {
      ForEach((center - Metric.sideCardCount)...(center + Metric.sideCardCount), id: \.self) { index in
        let d = Double(index) - position
        let distance = abs(d)
        let theme = Theme.at(index)

        ThemeCard(title: theme.title, description: theme.subtitle)
          .rotationEffect(.degrees(max(-1, min(1, d)) * Metric.angle))
          .offset(x: d * Metric.spacing, y: min(distance, 1) * Metric.drop)
          .opacity(1 - (1 - Metric.sideOpacity) * min(distance, 1))
          .zIndex(-distance)
          .onTapGesture { onSelect(index) }
      }
    }
  }
}

// MARK: - Metric

private enum Metric {
  static let spacing: Double = 207
  static let drop: Double = 55
  static let angle: Double = 16
  static let sideOpacity: Double = 0.8
  static let height: Double = 262
  // 보이는 카드 양 방향 1장 + 스크린 밖 1장
  static let sideCardCount: Int = 2
}

// MARK: - Theme+Index

private extension Theme {
  static func at(_ index: Int) -> Theme {
    let count = allCases.count
    return allCases[((index % count) + count) % count]
  }
}

#Preview {
  ThemeCarousel()
    .frameyGradientBackground()
}
