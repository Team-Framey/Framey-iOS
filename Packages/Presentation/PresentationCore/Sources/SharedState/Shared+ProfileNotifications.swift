import Sharing

extension SharedReaderKey where Self == AppStorageKey<Bool>.Default {
  public static var profileNotificationsEnabled: Self {
    Self[
      .appStorage("profileNotificationsEnabled"),
      default: true
    ]
  }
}
