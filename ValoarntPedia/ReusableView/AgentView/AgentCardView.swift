//
//  AgentCardView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import SwiftUI

struct AgentCardView: View {
    // MARK: - PROPERTIES
    @State private var isAnimating: Bool = false
    
    var agent: AgentOnboardingScreen
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                // AGENT: IMAGE
                Image(agent.photo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
                // AGENT: TITLE
                Text(agent.name)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2 , x: 2, y: 2)
                // AGENT: HEADLINE
                Text(agent.description)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .frame(maxWidth: 480)
                    
                // BUTTON: START
                StartButtonView()
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: agent.gradientColors), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }}

// MARK: - PREVIEW
struct AgentCardView_Previews: PreviewProvider {
    static var previews: some View {
        AgentCardView(agent: AgentOnboardingScreen.data[0])
    }
}
