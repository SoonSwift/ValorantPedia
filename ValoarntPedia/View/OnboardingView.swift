//
//  OnboardingView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingFeature: Reducer {
    struct State: Equatable {
        var data: [AgentOnboardingScreen] = AgentOnboardingScreen.data
    }
    
    enum Action: Equatable {
        case onAppear
        case didTapStart
    }
    
    var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}

struct OnboardingView: View {
    var store: StoreOf<OnboardingFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TabView {
                ForEach(viewStore.data, id: \.self) { agent in
                    AgentCardView(agent: agent) {
                        store.send(.didTapStart)
                    }
                }
            }
            .tabViewStyle(.page)
            .padding(.vertical, 20)
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

// MARK: - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(
            store: Store(
                initialState: OnboardingFeature.State(),
                reducer: { OnboardingFeature() }
            )
        )
    }
}
