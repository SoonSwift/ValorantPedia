//
//  AbilitiesView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 08/09/2023.
//

import SwiftUI

struct AbilitiesView: View {
    // MARK: - PROPERTIES
    
    var agent: AgentInfo

    // MARK: - BODY
    var body: some View {
        VStack {
            ForEach(agent.abilities) { ability in
                GroupBox {
                    HStack {
                        if let imageUrl = ability.displayIcon {
                            AsyncImage(url: URL(string: imageUrl)!) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .padding(.horizontal, 20)
                            } placeholder: {
                                ProgressView()
                            }
                            .padding(8)
                            .background(Color(red: 0.2, green: 0.2, blue: 0.2))
                            .cornerRadius(20)
                            .padding(.trailing, 10)
                        }
                        VStack(alignment: .leading) {
                            Text(ability.displayName)
                                .font(.headline)
                            Text(ability.description)
                                .font(.caption)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct AbilitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AbilitiesView(agent: AgentInfo.agentPreview)
    }
}
