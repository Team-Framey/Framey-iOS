import PresentationCore
import SwiftUI

struct ProfileConfirmationModal: View {
  let dialog: ProfileFeature.Dialog
  let onConfirm: () -> Void
  let onCancel: () -> Void

  var body: some View {
    Modal(title: dialog.title, description: dialog.description) {
      Button(action: onConfirm) {
        Text(dialog.primaryButtonTitle)
          .frame(maxWidth: .infinity, minHeight: 24)
      }

      Button(action: onCancel) {
        Text("취소")
          .frame(maxWidth: .infinity, minHeight: 24)
      }
    }
  }
}

private extension ProfileFeature.Dialog {
  var title: String {
    switch self {
    case .logout: "로그아웃할까요?"
    case .withdrawal: "정말 탈퇴할까요?"
    }
  }

  var description: String {
    switch self {
    case .logout: "이 기기에서 로그아웃돼요.\n보관함의 콜라주는 그대로 유지됩니다."
    case .withdrawal: "탈퇴하면 보관함에 저장된 콜라주가 전부 삭제돼요.\n그래도 탈퇴할까요?"
    }
  }

  var primaryButtonTitle: String {
    switch self {
    case .logout: "로그아웃"
    case .withdrawal: "탈퇴하기"
    }
  }
}
