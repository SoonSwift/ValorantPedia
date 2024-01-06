//
//  MapListView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 09/09/2023.
//

import SwiftUI
import ComposableArchitecture

struct MapListFeature: Reducer {
    @Dependency(\.valorantManager)
    private var valorantManager
    
    struct State: Equatable {
        var maps: MapResult?
    }
    
    enum Action: Equatable {
        case onAppear
        case onMapResult(TaskResult<MapResult>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if state.maps == nil {
                    
                    return .run { send in
                        await send(
                            .onMapResult(
                                TaskResult { try await valorantManager.getMapsAsync() }
                            )
                        )
                    }
                } else {
                    return .none
                }
                
            case .onMapResult(.success(let result)):
                print("maps")
                state.maps = result
                return .none
                
            case .onMapResult(.failure):
                print("mapssssss")
                return .none
                
            }
        }
    }
}

struct MapListView: View {
    // MARK: - PROPERITES
    let store: StoreOf<MapListFeature>

    @ObservedObject
    var viewStore: ViewStoreOf<MapListFeature>

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    // MARK: - BODY
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewStore.maps?.data ?? []) { map in
                    NavigationLink {
                        MapDetailView(map: map)
                    } label: {
                        MapRowListView(map: map)
                    }
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
    
    init(store: StoreOf<MapListFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
}

// MARK: - PREVIEW
struct MapListView_Previews: PreviewProvider {
    static var previews: some View {
        MapListView(store: Store(initialState: MapListFeature.State(), reducer: { MapListFeature() }))
                .environmentObject(ViewModel())
    }
}
