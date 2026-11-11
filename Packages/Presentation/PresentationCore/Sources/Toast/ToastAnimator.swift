import Dependencies
import DesignSystem
import SwiftUI

@MainActor
final class ToastAnimator: ObservableObject {
  @Published var isPresented = false

  func show() {
    @Dependency(\.continuousClock) var clock
    Task { @MainActor in
      try? await clock.sleep(for: .milliseconds(50))
      isPresented = true
    }
  }

  func dismiss() async {
    @Dependency(\.continuousClock) var clock
    isPresented = false
    try? await clock.sleep(for: .milliseconds(400))
  }
}

struct ToastAnimatorContainer: View {
  let toast: Toast
  @ObservedObject var animator: ToastAnimator

  var body: some View {
    Group {
      switch toast.style {
      case .success:
        ToastContainer(
          content: ToastView(icon: .successTinted, message: toast.message),
          isPresented: $animator.isPresented
        )
      }
    }
    .onAppear {
      animator.show()
    }
  }
}

struct ToastContainer<Content: View>: View {
  let content: Content
  @Binding var isPresented: Bool

  var body: some View {
    VStack {
      Spacer()

      content
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
    }
    .offset(y: isPresented ? 0 : 200)
    .opacity(isPresented ? 1 : 0)
    .animation(.spring(duration: 0.4), value: isPresented)
  }
}
