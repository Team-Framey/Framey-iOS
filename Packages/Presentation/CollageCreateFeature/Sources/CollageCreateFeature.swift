import Foundation
import PresentationCore
import struct _PhotosUI_SwiftUI.PhotosPickerItem

@Reducer
public struct CollageCreateFeature {
  @ObservableState
  public struct State: Equatable {
    var isEnabled: Bool {
      !photoItems.isEmpty
        && photoItems.count <= maximumPhotoCount
        && selectedPhotos.map(\.item) == photoItems
        && selectedPhotos.allSatisfy { $0.data != nil }
        && theme != nil
    }
    var isPhotoPickerPresented = false
    let maximumPhotoCount = 6
    var photoItems: [PhotosPickerItem] = []
    var selectedPhotos: IdentifiedArrayOf<SelectedPhoto> = .init()
    var theme: Theme?

    public init() {}
  }

  @CasePathable
  public enum Action: ViewAction {
    case delegate(Delegate)
    case local(Local)
    case view(View)

    public enum Delegate {
      case createRequested(photos: [Data], theme: Theme)
    }

    @CasePathable
    public enum Local {
      case photoOnChanged
      case photoLoadResponse(UUID, Result<Data, Error>)
    }

    @CasePathable
    public enum View: BindableAction {
      case addTapped
      case binding(BindingAction<State>)
      case closeTapped
      case createTapped
      case photoDeleteTapped(PhotosPickerItem)
      case themeTapped(Theme)
    }
  }

  private enum CancelID: Hashable {
    case photoLoad(UUID)
  }

  @Dependency(PhotoDataLoader.self) private var photoDataLoader
  @Dependency(\.dismiss) private var dismiss
  @Dependency(\.uuid) private var uuid

  public init() {}

  public var body: some ReducerOf<Self> {
    CombineReducers {
      BindingReducer(action: \.view)
      Reduce { state, action in
        switch action {
        case .delegate:
          return .none

        case let .local(action):
          return local(&state, action)

        case .view(.addTapped):
          state.isPhotoPickerPresented = true
          return .none

        case .view(.binding):
          return .none

        case .view(.closeTapped):
          return .run { [dismiss] _ in
            await dismiss()
          }

        case .view(.createTapped):
          guard state.isEnabled, let theme = state.theme else {
            return .none
          }
          return .send(.delegate(.createRequested(
            photos: state.selectedPhotos.compactMap(\.data),
            theme: theme
          )))

        case let .view(.photoDeleteTapped(item)):
          state.photoItems.removeAll { $0 == item }
          return .none

        case let .view(.themeTapped(theme)):
          state.theme = theme
          return .none
        }
      }
    }
    .onChange(of: \.photoItems) { _, _ in
      Reduce { _, _ in
        .send(.local(.photoOnChanged))
      }
    }
  }

  private func local(_ state: inout State, _ action: Action.Local) -> Effect<Action> {
    switch action {
    case .photoOnChanged:
      let previousPhotos = state.selectedPhotos
      var effects: [Effect<Action>] = previousPhotos
        .filter { !state.photoItems.contains($0.item) }
        .map { .cancel(id: CancelID.photoLoad($0.id)) }

      state.selectedPhotos = .init(
        uniqueElements: state.photoItems.map { item in
          if let photo = previousPhotos.first(where: { $0.item == item }) {
            return photo
          }
          let photo = SelectedPhoto(id: uuid(), item: item)
          effects.append(
            .run { [photoDataLoader, id = photo.id] send in
              let data = try await photoDataLoader.load(item: item)
              await send(.local(.photoLoadResponse(id, .success(data))))
            } catch: { [id = photo.id] error, send in
              await send(.local(.photoLoadResponse(id, .failure(error))))
            }.cancellable(
              id: CancelID.photoLoad(photo.id),
              cancelInFlight: true
            )
          )
          return photo
        }
      )
      return .merge(effects)

    case let .photoLoadResponse(id, result):
      state.selectedPhotos[id: id]?.updatePhotoResult(result)
      return .none
    }
  }
}
