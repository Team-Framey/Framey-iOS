import PresentationCore
import SwiftUI

struct ProfileAccountIdentityRow: View {
  let user: FrameyUser

  var body: some View {
    HStack(spacing: 9) {
      accountIcon
        .accessibilityHidden(true)

      Text(user.email)
        .typography(.enM16Tight)
        .foregroundStyle(.framey(.gray900))
        .lineLimit(1)
        .truncationMode(.middle)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .accessibilityElement(children: .ignore)
    .accessibilityLabel(Text("\(loginProviderName) 계정, \(user.email)"))
  }

  private var loginProviderName: String {
    switch user.loginType {
    case .apple: "애플"
    case .google: "구글"
    case .kakao: "카카오"
    }
  }

  private var accountIcon: some View {
    Circle()
      .fill(.framey(accountBackgroundColor))
      .frame(width: 26, height: 26)
      .overlay {
        accountImage
          .resizable()
          .scaledToFit()
          .frame(width: 16, height: 16)
      }
  }

  private var accountBackgroundColor: FrameyColor {
    switch user.loginType {
    case .apple: .gray900
    case .google: .white
    case .kakao: .kakaoBG
    }
  }

  private var accountImage: Image {
    switch user.loginType {
    case .apple: ResoureKitAsset.appleIcon.image
    case .google: ResoureKitAsset.googleIcon.image
    case .kakao: ResoureKitAsset.kakaoIcon.image
    }
  }
}
