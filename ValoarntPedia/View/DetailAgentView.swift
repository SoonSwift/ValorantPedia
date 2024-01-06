//
//  DetailAgentView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 08/09/2023.
//

import SwiftUI

struct DetailAgentView: View {
    // MARK: - PROPERTIES
    
    var agent: AgentInfo
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    // HEADER
                    AgentHeaderView(agent: agent)
                    VStack(alignment: .leading, spacing: 20){
                        // TITLE
                        Text(agent.displayName)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        // DESCRIPTION
                        Text("// BIOGRAPHY")
                            .font(.headline)
                            .bold()
                        Text(agent.description)
                            .multilineTextAlignment(.leading)
                        // SPECIAL ABILITIES
                        Text("// SPECIAL ABILITIES")
                            .font(.headline)
                            .bold()
                        AbilitiesView(agent: agent)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: 640, alignment: .center)
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationViewStyle(StackNavigationViewStyle())
            .edgesIgnoringSafeArea(.top)
        }
    }
}

//// MARK: - PREVIEW
//struct DetailAgentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailAgentView(agent: AgentInfo.agentPreview)
//    }
//}
