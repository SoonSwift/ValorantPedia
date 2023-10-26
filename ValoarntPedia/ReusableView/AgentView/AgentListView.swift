//
//  AgentListView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 08/09/2023.
//

import SwiftUI

struct AgentListView: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var viewModel: ViewModel
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
                
                if let agents = viewModel.agents?.data {
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
    }

}

// MARK: - PREVIEW
struct AgentListView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
    }
}
