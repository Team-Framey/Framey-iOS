import Entity
import Sharing

extension SharedReaderKey where Self == InMemoryKey<FrameyUser?>.Default {
  public static var user: Self {
    Self[
      .inMemory("frameyUser"),
      default: nil
    ]
  }
}
