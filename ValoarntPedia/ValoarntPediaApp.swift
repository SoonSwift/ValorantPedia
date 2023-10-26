//
//  ValoarntPediaApp.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import SwiftUI

@main
struct ValoarntPediaApp: App {
    // MARK: - PROPETIES
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
            } else {
                MainView()
                    .environmentObject(ViewModel())
            }
        }
    }
}
