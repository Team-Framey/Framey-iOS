import PresentationCore
import SwiftUI

struct ProfileNotificationToggle: View {
  @Binding var isOn: Bool

  var body: some View {
    Toggle(isOn: $isOn) {
      Text("알림 설정")
        .typography(.bodyM16Tight)
        .foregroundStyle(.framey(.gray900))
    }
    .toggleStyle(ProfileNotificationToggleStyle())
  }
}

private struct ProfileNotificationToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    Button {
      configuration.isOn.toggle()
    } label: {
      HStack {
        configuration.label

        Spacer()

        Capsule()
          .fill(.framey(configuration.isOn ? .primary500 : .gray300))
          .frame(width: 46, height: 28)
          .overlay(alignment: configuration.isOn ? .trailing : .leading) {
            Circle()
              .fill(.framey(.white))
              .frame(width: 22, height: 22)
              .padding(3)
          }
          .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
      }
      .padding(.vertical, .s10)
      .contentShape(.rect)
    }
    .buttonStyle(.plain)
    .accessibilityRepresentation {
      Toggle(isOn: configuration.$isOn) {
        configuration.label
      }
      .toggleStyle(.switch)
    }
  }
}
