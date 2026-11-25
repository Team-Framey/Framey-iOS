import PresentationCore
import SwiftUI

struct ProfileAccountIdentityRow: View {
  let user: FrameyUser

  var body: some View {
    HStack(spacing: 9) {
      accountIcon
        .accessibilityHidden(true)

      Text(user.email)
        .tracking(-0.48)
        .typography(.enM16)
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
    ZStack {
      let backgroundColor: FrameyColor = switch user.loginType {
      case .apple: .gray900
      case .google: .white
      case .kakao: .kakaoBG
      }

      Circle()
        .fill(.framey(backgroundColor))

      switch user.loginType {
      case .apple:
        ResoureKitAsset.appleIcon.image
          .resizable()
          .scaledToFit()
          .frame(width: 16, height: 16)

      case .google:
        ResoureKitAsset.googleIcon.image
          .resizable()
          .scaledToFit()
          .frame(width: 16, height: 16)

      case .kakao:
        ResoureKitAsset.kakaoIcon.image
          .resizable()
          .scaledToFit()
          .frame(width: 16, height: 16)
      }
    }
    .frame(width: 26, height: 26)
  }
}
