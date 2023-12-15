//
//  GunsListView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 29/09/2023.
//

import SwiftUI
import ComposableArchitecture

struct GunsListFeature: Reducer {
    @Dependency(\.valorantManager)
    private var valorantManager
    
    struct State: Equatable {
        var guns: GunResult?
    }
    
    enum Action: Equatable {
        case onAppear
        case onGunResult(TaskResult<GunResult>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(
                        .onGunResult(
                            TaskResult { try await valorantManager.getGunsAsync() }
                        )
                    )
                }
            case .onGunResult(.success(let result)):
                print("guns")
                state.guns = result
                return .none
                
            case .onGunResult(.failure):
                print("gunserr")
                return .none
            }
        }
    }
}

struct GunsListView: View {
    // MARK: - PROPERTIES
    
    let store: StoreOf<GunsListFeature>
    
    @ObservedObject
    var viewStore: ViewStoreOf<GunsListFeature>
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    // MARK: - BODY
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns ) {
                ForEach(viewStore.guns?.data ?? []) { gun in
                    NavigationLink {
                        GunDetailView(gun: gun)
                    } label: {
                        GunRowListView(gun: gun)
                    }
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
    
    init(store: StoreOf<GunsListFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
}
//
//// MARK: - PREVIEW
//#Preview {
//    GunsListView()
//        .environmentObject(ViewModel())
//}

//// MARK: - PREVIEW
struct GunsListView_Previews: PreviewProvider {
    static var previews: some View {
        GunsListView(
            store: Store(
                initialState: GunsListFeature.State(),
                reducer: { GunsListFeature() }
            )
        )
    }
}
