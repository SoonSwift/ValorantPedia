//
//  ValoarntPediaApp.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct ValoarntPediaApp: App {
    var body: some Scene {
        WindowGroup {
            ValoarntPediaView(
                store: Store(
                    initialState: AppReducer.State(),
                    reducer: { AppReducer() }
                )
            )
        }
    }
}

struct AppReducer: Reducer {
    struct State: Equatable {
        var isOnboarding = false
        var onboarding = OnboardingFeature.State()
        var main = MainFeature.State()
    }
    
    enum Action: Equatable {
        case onboarding(OnboardingFeature.Action)
        case main(MainFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.onboarding, action: /Action.onboarding, child: OnboardingFeature.init)
        Scope(state: \.main, action: /Action.main, child: MainFeature.init)
        Reduce { state, action in
            switch action {
            case .onboarding(.didTapStart):
                state.isOnboarding = false
                return .none
                
            case .onboarding(.onAppear):
                return .none
                
            case .main:
                return .none
            }
        }//._printChanges()
    }
}

struct ValoarntPediaView: View {
    let store: StoreOf<AppReducer>
    
    struct ViewState: Equatable {
        let isOnboarding: Bool
        
        init(state: AppReducer.State) {
            self.isOnboarding = state.isOnboarding
        }
    }
    
    var body: some View {
        WithViewStore(store, observe: ViewState.init) { viewStore in
            if viewStore.isOnboarding {
                OnboardingView(
                    store: store.scope(state: \.onboarding, action: { .onboarding($0) })
                )
            } else {
                MainView(
                    store: store.scope(state: \.main, action: { .main($0) }))
            }
        }
    }
}

struct ValoarntPediaApp_Previews: PreviewProvider {
    static var previews: some View {
        ValoarntPediaView(
            store: Store(initialState: AppReducer.State(), reducer: { AppReducer() }))
    }
}
