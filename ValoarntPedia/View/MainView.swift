//
//  ContentView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import SwiftUI
import ComposableArchitecture

struct MainFeature: Reducer {
    struct State: Equatable {
        @BindingState
        var selectedTab = TabItem.house
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case onAppear
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                //viewModel.fetchAgenets()
                return .none
            case .binding:
                return .none
            }
        }
    }
}

struct MainView: View {
    // MARK: - PROPERTIES
    
    @AppStorage("systemThemeVal") private var systemTheme: Int = SchameType.allCases.first!.rawValue

    private var selectedSchame: ColorScheme? {
        guard let theme = SchameType(rawValue: systemTheme) else { return nil }
        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
    
   // @EnvironmentObject var viewModel: ViewModel
   // @State private var selectedTab = TabItem.house
    
    var store: StoreOf<MainFeature>
    
    // MARK: - BODY
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                if viewStore.selectedTab == TabItem.house {
                    VStack {
                        Text("test1")
                        Spacer()
                    }
                    
                    //                    AgentListView()
                    //                        .onAppear {
                    //                            store.send(.onAppear)
                    //                        }
                } else if viewStore.selectedTab == .map {
                    //MapListView()
                    VStack {
                        Text("test2")
                        Spacer()
                    }
                } else if viewStore.selectedTab == .book {
                    //GunsListView()
                    VStack {
                        Text("test3")
                        Spacer()
                    }
                } else {
                    SettingsView()
                }
                ZStack(alignment: .bottom) {
                    CustomTabBar(selectedTab: viewStore.$selectedTab)
                }
            }
            .preferredColorScheme(selectedSchame)
        }
    }
}

// MARK: - PREVIEW
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store:
                Store(
                    initialState: MainFeature.State(),
                    reducer: { MainFeature() }
                )
        )
    }
}
