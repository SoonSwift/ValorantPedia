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
        
        var agents = AgentListFeature.State()
        var guns = GunsListFeature.State()
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case agents(AgentListFeature.Action)
        case guns(GunsListFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Scope(state: \.agents, action: /Action.agents, child: AgentListFeature.init)
        Scope(state: \.guns, action: /Action.guns, child: GunsListFeature.init)
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .binding, .agents, .guns:
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
                    AgentListView(
                        store: store.scope(
                            state: \.agents,
                            action: { .agents($0) }
                        )
                    )
                } else if viewStore.selectedTab == .map {
                    //MapListView()
                    VStack {
                        Text("test2")
                        Spacer()
                    }
                } else if viewStore.selectedTab == .book {
                    GunsListView(
                        store: store.scope(
                            state: \.guns,
                            action: { .guns($0) }
                        )
                    )
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
