//
//  MapDetailView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 28/09/2023.
//

import SwiftUI

struct MapDetailView: View {
    // MARK: - PROPERTIES
    
    let map: MapInfo
    
    // MARK: - BODY
    var body: some View {
        ScrollView {
            
            // IMAGE
            AsyncImage(url: URL(string: map.splash ?? "")!) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .overlay (
                HStack {
                    Text(map.coordinates ?? "")
                        .fontWeight(.bold)
                }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(
                        Color.blue
                            .opacity(0.4)
                            .cornerRadius(6)
                    )
                    .padding(12)
                
                , alignment: .bottomLeading
            )

            // TITLE
            Text(map.displayName.uppercased())
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .padding(.vertical, 16)
                .foregroundColor(.primary)
                .background(
                    Color.accentColor
                        .frame(height: 6)
                        .offset(y: 24)
                )
            
            // DESCRIPTION
            Text(map.narrativeDescription ?? "")
                .font(.headline)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            
            if let mapTacticalDescription = map.tacticalDescription {
                Group {
                    HeadingView(headingImage: "poweroutlet.type.o.fill", headingText: "Type of sites on map")
                    Text(mapTacticalDescription)
                }
                .padding(.horizontal)
                
                GroupBox {
                    if let mapTacticalView = map.displayIcon {
                        HeadingView(headingImage: "square.stack.3d.up.fill", headingText: "Tactical view")
                        AsyncImage(url: URL(string: mapTacticalView)!) { image in
                                image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .navigationTitle("Learn about \(map.displayName)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//// MARK: - PREVIEW
//#Preview {
//    return NavigationView {
//        MapDetailView(map: MapInfo.previewExample)
//    }
//}
