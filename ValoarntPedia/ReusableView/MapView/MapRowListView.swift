//
//  MapRowListView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 27/09/2023.
//

import SwiftUI

struct MapRowListView: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var viewModel: ViewModel
    
    let map: MapInfo
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: map.splash ?? "")!) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170)
                    .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                    )
            } placeholder: {
                ProgressView()
            }
            
            Text(map.displayName)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    MapRowListView(map: MapInfo.previewExample)
        .environmentObject(ViewModel())
}
