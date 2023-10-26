//
//  MapListView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 09/09/2023.
//

import SwiftUI

struct MapListView: View {
    // MARK: - PROPERITES
    
    @EnvironmentObject var viewModel: ViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    // MARK: - BODY
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.maps?.data ?? []) { map in
                    NavigationLink {
                        MapDetailView(map: map)
                    } label: {
                        MapRowListView(map: map)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchMaps()
        }
    }
}

// MARK: - PREVIEW
struct MapListView_Previews: PreviewProvider {
    static var previews: some View {
            MapListView()
                .environmentObject(ViewModel())
    }
}
