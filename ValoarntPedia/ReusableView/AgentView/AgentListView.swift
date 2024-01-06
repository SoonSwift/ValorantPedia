//
//  AgentListView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 08/09/2023.
//

import SwiftUI
import ComposableArchitecture

private enum ValorantManagerKey: DependencyKey {
    static var liveValue: ValorantManagerPrototype = ValorantManager(fetchableManager: Bundle.main)
    //static var previewValue: ValorantManagerPrototype = MockValorantManager()
//    static var testValue: ValorantManagerPrototype = MockValorantManager()
}

extension DependencyValues {
    var valorantManager: ValorantManagerPrototype {
        get { self[ValorantManagerKey.self] }
        set { self[ValorantManagerKey.self] = newValue }
    }
}

struct AgentListFeature: Reducer {
    @Dependency(\.valorantManager)
    private var valorantManager
    
    struct State: Equatable {
        var agents: AgentResult?
    }
    
    enum Action: Equatable {
        case onAppear
        case onAgentResult(TaskResult<AgentResult>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(
                        .onAgentResult(
                            TaskResult { try await valorantManager.getAgentsAsync() }
                        )
                    )
                }
            case .onAgentResult(.success(let result)):
                state.agents = result
                return .none
                
            case .onAgentResult(.failure):
                return .none
            }
        }
    }
}

struct AgentListView: View {
    // MARK: - PROPERTIES
    
    let store: StoreOf<AgentListFeature>
    
    @ObservedObject
    var viewStore: ViewStoreOf<AgentListFeature>
    
    private let adaptiveColumns = [GridItem(.adaptive(minimum: 150))]
        
    // MARK: - BODY
    var body: some View {
        ScrollView {
            VStack {
                Image("Valorant-Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                
                Text("Choose your agent")
                    .bold()
                    .font(.largeTitle)
                
                Text("Find more ways to plant the Spike and style on your Enemies with scrappers, strategists and hunters of every description")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding()

                if let agents = viewStore.agents?.data {
                    ForEach(0..<agents.count, id: \.self) { index in
                        if index % 2 == 0 {
                            HStack(spacing: 10) {
                                NavigationLink {
                                    DetailAgentView(agent: agents[index])
                                } label: {
                                    MainAgentCardView(agent: agents[index])
                                }

                                if index + 1 < agents.count {
                                    NavigationLink {
                                        DetailAgentView(agent: agents[index + 1])
                                    } label: {
                                        MainAgentCardView(agent: agents[index + 1])
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                }
            }
        }
        .tag("hause")
        .onAppear {
            store.send(.onAppear)
        }
    }
    
    init(store: StoreOf<AgentListFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

}

//// MARK: - PREVIEW
struct AgentListView_Previews: PreviewProvider {
    static var previews: some View {
        AgentListView(
            store: Store(
                initialState: AgentListFeature.State(),
                reducer: { AgentListFeature() }
            )
        )
    }
}
