import PresentationCore
import SwiftUI

extension Theme {
  var title: String {
    switch self {
    case .simple: "Simple"
    case .default: "Default"
    case .kitsch: "Kitsch"
    }
  }

  var subtitle: String {
    switch self {
    case .simple: "군더더기 없이 깔끔하게,\n사진 본연의 매력을 담은 프레임"
    case .default: "은은한 감성을 더해\n일상을 분위기 있게 담는 프레임"
    case .kitsch: "개성과 유니크한 매력으로\n시선을 사로잡는 프레임"
    }
  }

  var backgroundImage: Image {
    switch self {
    case .simple: ResoureKitAsset.themePreviewSimple.image
    case .default: ResoureKitAsset.themePreviewDefault.image
    case .kitsch: ResoureKitAsset.themePreviewKitsch.image
    }
  }
}
