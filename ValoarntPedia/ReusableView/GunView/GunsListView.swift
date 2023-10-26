//
//  GunsListView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 29/09/2023.
//

import SwiftUI

struct GunsListView: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var viewModel: ViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    // MARK: - BODY
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns ) {
                ForEach(viewModel.guns?.data ?? []) { gun in
                    NavigationLink {
                        GunDetailView(gun: gun)
                    } label: {
                        GunRowListView(gun: gun)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchGuns()
        }
    }
}

// MARK: - PREVIEW
#Preview {
    GunsListView()
        .environmentObject(ViewModel())
}
