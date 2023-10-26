//
//  OnboardingView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var viewModel: ViewModel
    
    // MARK: - BODY
    var body: some View {
        TabView {
            ForEach(AgentOnboardingScreen.data, id: \.self) { agent in
                AgentCardView(agent: agent)
            }
        }
        .tabViewStyle(.page)
        .padding(.vertical, 20)
    }
}

// MARK: - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(ViewModel())
    }
}
