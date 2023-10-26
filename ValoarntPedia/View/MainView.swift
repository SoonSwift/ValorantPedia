//
//  ContentView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import SwiftUI

struct MainView: View {
    // MARK: - PROPERTIES
    
    @AppStorage("systemThemeVal") private var systemTheme: Int = SchameType.allCases.first!.rawValue

    private var selectedSchame: ColorScheme? {
        guard let theme = SchameType(rawValue: systemTheme) else { return nil }
        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
    
    @EnvironmentObject var viewModel: ViewModel
    @State private var selectedTab = TabItem.house
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            if selectedTab == .house {
                AgentListView()
                    .onAppear {
                        viewModel.fetchAgenets()
                    }
            } else if selectedTab == .map {
                MapListView()
            } else if selectedTab == .book {
                GunsListView()
            } else {
                SettingsView()
            }
            
            ZStack(alignment: .bottom) {
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .preferredColorScheme(selectedSchame)
    }
}

// MARK: - PREVIEW
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
    }
}
