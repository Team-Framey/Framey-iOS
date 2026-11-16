import SwiftUI

extension View {
  public func modal<Content: View>(
    isPresented: Binding<Bool>,
    dismissOnBackgroundTap: Bool = false,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    background {
      ModalPresenter(
        isPresented: isPresented,
        dismissOnBackgroundTap: dismissOnBackgroundTap,
        onDismiss: onDismiss,
        content: content
      )
    }
  }

  public func modal<Title: StringProtocol, Description: StringProtocol, Primary: View, Secondary: View>(
    isPresented: Binding<Bool>,
    alignment: ModalAlignment = .horizontal,
    title: Title,
    description: Description,
    dismissOnBackgroundTap: Bool = false,
    onDismiss: (() -> Void)? = nil,
    @ModalFooterBuilder actions: @escaping () -> ModalFooterContent<Primary, Secondary>
  ) -> some View {
    modal(
      isPresented: isPresented,
      dismissOnBackgroundTap: dismissOnBackgroundTap,
      onDismiss: onDismiss
    ) {
      Modal(
        alignment,
        title: title,
        description: description,
        actions: actions
      )
    }
  }

  public func modal<Title: StringProtocol, Primary: View, Secondary: View>(
    isPresented: Binding<Bool>,
    alignment: ModalAlignment = .horizontal,
    title: Title,
    dismissOnBackgroundTap: Bool = false,
    onDismiss: (() -> Void)? = nil,
    @ModalFooterBuilder actions: @escaping () -> ModalFooterContent<Primary, Secondary>
  ) -> some View {
    modal(
      isPresented: isPresented,
      dismissOnBackgroundTap: dismissOnBackgroundTap,
      onDismiss: onDismiss
    ) {
      Modal(
        alignment,
        title: title,
        actions: actions
      )
    }
  }
}
