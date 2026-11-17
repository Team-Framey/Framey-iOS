import DesignSystem
import Entity
import SwiftUI

// TODO: - 테마 이미지 추가

public struct CollageThemeRow: View {
  public let theme: Theme
  public let isSelected: Bool
  public let action: () -> Void

  public init(
    theme: Theme,
    isSelected: Bool,
    action: @escaping () -> Void
  ) {
    self.theme = theme
    self.isSelected = isSelected
    self.action = action
  }

  public var body: some View {
    Button(action: action) {
      VStack(alignment: .leading, spacing: .s8) {
        Text(title)
          .typography(.enSB18)
          .foregroundStyle(.framey(.gray800))
          .frame(maxWidth: .infinity, alignment: .leading)

        Text(description)
          .typography(.bodyR14)
          .foregroundStyle(.framey(.gray500))
          .multilineTextAlignment(.leading)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(.s20)
      .background {
        shape
          .fill(backgroundColor)
      }
      .overlay {
        shape
          .stroke(.framey(.primary500), lineWidth: isSelected ? 2 : 0)
      }
    }
    .buttonStyle(.plain)
  }

  private var shape: some Shape {
    FrameyRoundedShape(token: .xl)
  }

  private var title: String {
    switch theme {
    case .simple: "Simple"
    case .default: "Default"
    case .kitsch: "Kitsch"
    }
  }

  private var description: String {
    switch theme {
    case .simple: "군더더기 없이 깔끔하게,\n사진 본연의 매력을 담은 프레임"
    case .default: "은은한 감성을 더해\n일상을 분위기 있게 담는 프레임"
    case .kitsch: "개성과 유니크한 매력으로\n시선을 사로잡는 프레임"
    }
  }

  private var backgroundColor: Color {
    switch theme {
    case .simple: FrameyColor.gray100.color
    case .default: Color.hex(0xB9EBFE)
    case .kitsch: FrameyColor.yellow.color
    }
  }
}
