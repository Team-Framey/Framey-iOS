import PresentationCore
import SwiftUI

@ViewAction(for: ProfileFeature.self)
public struct ProfileView: View {
  public let store: StoreOf<ProfileFeature>

  public init(store: StoreOf<ProfileFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack {
      Text("Profile")
        .typography(.displaySB36)
        .foregroundStyle(.framey(.gray900))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .backgroundStyle(.framey(.white))
  }
}
