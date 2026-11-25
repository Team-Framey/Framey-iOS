import PresentationCore
import SwiftUI

struct ProfileConfirmationModal: View {
  let dialog: ProfileFeature.Dialog
  let onConfirm: () -> Void
  let onCancel: () -> Void

  var body: some View {
    let isLogout = dialog == .logout

    Modal(
      title: isLogout ? "로그아웃할까요?" : "정말 탈퇴할까요?",
      description: isLogout
        ? "이 기기에서 로그아웃돼요.\n보관함의 콜라주는 그대로 유지됩니다."
        : "탈퇴하면 보관함에 저장된 콜라주가 전부 삭제돼요.\n그래도 탈퇴할까요?"
    ) {
      Button(action: onConfirm) {
        Text(isLogout ? "로그아웃" : "탈퇴하기")
          .frame(maxWidth: .infinity, minHeight: 24)
      }

      Button(action: onCancel) {
        Text("취소")
          .frame(maxWidth: .infinity, minHeight: 24)
      }
    }
  }
}
