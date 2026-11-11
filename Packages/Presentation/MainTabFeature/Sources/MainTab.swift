import Foundation
import PresentationCore

public enum MainTab: CaseIterable, Hashable, Sendable {
  case home
  case library
  case profile
}

extension MainTab: Identifiable {
  public var id: MainTab { self }
}

// MARK: - BottomNavigationItem

extension MainTab: BottomNavigationItem {
  public var asset: ResoureKitAsset {
    switch self {
    case .home: .bottomNavigationHome
    case .library: .bottomNavigationLibrary
    case .profile: .bottomNavigationProfile
    }
  }

  public var selectedAsset: ResoureKitAsset {
    switch self {
    case .home: .bottomNavigationHomeSelected
    case .library: .bottomNavigationLibrarySelected
    case .profile: .bottomNavigationProfileSelected
    }
  }
}
