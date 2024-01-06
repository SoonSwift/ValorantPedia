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
        
        var visitedTabs = [TabItem.house]
        
        var agents = AgentListFeature.State()
        var guns = GunsListFeature.State()
        var maps = MapListFeature.State()
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case agents(AgentListFeature.Action)
        case guns(GunsListFeature.Action)
        case maps(MapListFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Scope(state: \.agents, action: /Action.agents, child: AgentListFeature.init)
        Scope(state: \.guns, action: /Action.guns, child: GunsListFeature.init)
        Scope(state: \.maps, action: /Action.maps, child: MapListFeature.init)
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .binding(\.$selectedTab):
                if !state.visitedTabs.contains(state.selectedTab) {
                    state.visitedTabs.append(state.selectedTab)
                }
                return .none
                
            case .binding, .agents, .guns, .maps:
                return .none
            }
        }
    }
}

struct MainView: View {
    struct ViewState: Equatable {
        @BindingViewState
        var selectedTab: TabItem
        var visitedTabs: [TabItem]
        
        init(store: BindingViewStore<MainFeature.State>) {
            self._selectedTab = store.$selectedTab
            self.visitedTabs = store.visitedTabs
        }
    }
    
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
        WithViewStore(store, observe: ViewState.init) { viewStore in
            ZStack {
                NavigationStack {
                    if viewStore.visitedTabs.contains(TabItem.house) {
                        AgentListView(
                            store: store.scope(
                                state: \.agents,
                                action: { .agents($0) }
                            )
                        )
                    }
                }
                .opacity(viewStore.selectedTab == TabItem.house ? 1 : 0)
                .border(.red)
                
                NavigationStack {
                    if viewStore.visitedTabs.contains(TabItem.map) {
                        MapListView(
                            store: store.scope(
                                state: \.maps,
                                action: { .maps($0) }
                            )
                        )
                    }
                }
                .opacity(viewStore.selectedTab == .map ? 1 : 0)
                .border(.yellow)
                
                NavigationStack {
                    if viewStore.visitedTabs.contains(TabItem.book) {
                        GunsListView(
                            store: store.scope(
                                state: \.guns,
                                action: { .guns($0) }
                            )
                        )
                    }
                    
                    
                    
                }
                    .opacity(viewStore.selectedTab == .book ? 1 : 0)
                    .border(.blue)
                
                NavigationStack {
                    if viewStore.visitedTabs.contains(TabItem.gearshape) {
                        SettingsView()
                    }
                    
                    
                        
                }
                .opacity(viewStore.selectedTab == .gearshape ? 1 : 0)
                .border(.green)
            }
            
            
            ZStack(alignment: .bottom) {
                CustomTabBar(selectedTab: viewStore.$selectedTab)
            }
            
        }
        .preferredColorScheme(selectedSchame)
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
