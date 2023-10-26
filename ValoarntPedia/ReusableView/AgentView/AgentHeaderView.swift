//
//  AgentHeaderView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 08/09/2023.
//

import SwiftUI

struct AgentHeaderView: View {
    // MARK: - PROPERTIES
    
    @State private var isAnimatingImage: Bool = false
    var agent: AgentInfo
    @State private var colors = [Color]()
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                AsyncImage(url: URL(string: agent.fullPortrait)!) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                        .padding(.vertical, 20)
                        .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
                        .onAppear {
                            withAnimation(.easeOut(duration: 0.5)) {
                                let backgroundGradientColors: [Color] = [
                                    Color(hex: agent.backgroundGradientColors[0]),
                                    Color(hex: agent.backgroundGradientColors[1])
                                ]
                                colors = backgroundGradientColors
                                isAnimatingImage = true
                            }
                        }
                } placeholder: {
                    ProgressView()
                }
                .overlay (
                    HStack {
                        AsyncImage(url: URL(string: agent.role.displayIcon)!) { image in
                            image
                                .image?.resizable()
                                .frame(width: 20, height: 20)
                        }
                        Text(agent.role.displayName)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(
                        Color.black
                        .opacity(0.4)
                        .cornerRadius(6)
                    )
                    .padding(12)

                    , alignment: .bottomLeading
                )
            }
        }
        .frame(height: 440)
        .onAppear {
      
        }
    }
}

// MARK: - PREVIEW
struct AgentHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AgentHeaderView(agent: AgentInfo.agentPreview)
    }
}
