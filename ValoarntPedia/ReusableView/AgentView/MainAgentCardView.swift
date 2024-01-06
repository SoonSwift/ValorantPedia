//
//  MainAgentCardView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 08/09/2023.
//

import SwiftUI

struct MainAgentCardView: View {
    // MARK: - PROPERTIES
    var agent: AgentInfo
    @State private var colors = [Color]()
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // AGENT: IMAGE
                if let imageURL = URL(string: agent.fullPortrait) {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        case .failure:
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                            } placeholder: {
                                ProgressView()
                            }
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Text("Invalid URL")
                }

                // AGENT: TITLE
                VStack {
                    Text(agent.displayName)
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.heavy)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2 , x: 2, y: 2)
                    Text(agent.role.displayName)
                        .foregroundColor(.white)
                        .font(.headline)
                        .fontWeight(.heavy)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2 , x: 2, y: 2)
                    
                }
                .padding(.bottom, 5)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                let backgroundGradientColors: [Color] = [
                    Color(hex: agent.backgroundGradientColors[0]),
                    Color(hex: agent.backgroundGradientColors[1])
                ]
                colors = backgroundGradientColors
            }
        }

        .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 400, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
    }
}
//
//// MARK: - PREVIEW
//struct MainAgentCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainAgentCardView(agent: AgentInfo.agentPreview)
//    }
//}
