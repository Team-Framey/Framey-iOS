import ResoureKit
import SwiftUI

public protocol BottomNavigationItem: Hashable, Identifiable, Sendable {
  var asset: ResoureKitAsset { get }
  var selectedAsset: ResoureKitAsset { get }
}

public struct BottomNavigation<Item: BottomNavigationItem>: View {
  @Binding private var selectedItem: Item
  private let items: [Item]

  public init(
    items: [Item],
    selectedItem: Binding<Item>
  ) {
    self.items = items
    self._selectedItem = selectedItem
  }

  public var body: some View {
    HStack(spacing: 12) {
      ForEach(items) { item in
        BottomNavigationButton(
          asset: item.asset,
          selectedAsset: item.selectedAsset,
          isSelected: selectedItem == item
        ) {
            selectedItem = item
          }
      }
    }
    .padding(.vertical, 16)
    .padding(.horizontal, 12)
    .background(.framey(.white).opacity(0.8), in: .capsule)
    .shadow(
      color: .hex(0x131414).opacity(0.1),
      radius: 14 / 2
    )
  }
}
