import SwiftUI

extension EnvironmentValues {
  @Entry var isLoading: Bool = false
}

extension View {
  public func isLoading(_ isLoading: Bool) -> some View {
    environment(\.isLoading, isLoading)
      .disabled(isLoading)
  }
}
