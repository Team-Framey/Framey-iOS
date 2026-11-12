import AppFeature
// TODO: - 로그인 설정 후 제거
import LoginUseCase
import PresentationCore
import SwiftUI

@main
struct FrameyApp: App {
  let store: StoreOf<AppFeature>

  init() {
    self.store = Store(initialState: AppFeature.State()) {
      AppFeature()
    } withDependencies: {
      // TODO: - 로그인 설정 후 제거
      $0[LoginUseCase.self] = .mockValue
    }
  }

  var body: some Scene {
    WindowGroup {
      AppView(store: store)
    }
  }
}
