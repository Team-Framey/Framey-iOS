import PresentationCore
import SwiftUI

public struct AppView: View {
  public let store: StoreOf<AppFeature>

  public init(store: StoreOf<AppFeature>) {
    self.store = store
  }

  public var body: some View {
    Text("Hello, Framey App")
  }
}
