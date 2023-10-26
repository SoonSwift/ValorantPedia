//
//  GunDetailView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 03/10/2023.
//

import SwiftUI

struct GunDetailView: View {
    // MARK: - PROPERTIES
    
    let gun: GunInfo
    
    // MARK: - BODY
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // IMAGE
                AsyncImage(url: URL(string: gun.displayIcon ?? "")!) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 20)
                } placeholder: {
                    ProgressView()
                }
                
                Text("\(gun.displayName?.uppercased() ?? "")")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                // GUN INFO
                Text("// GUN INFO")
                    .font(.headline)
                    .bold()
                
                GunInfoView(gun: gun)
                
                Text("// SKIN GALLERY")
                    .font(.headline)
                    .bold()
                // SKINS
                GroupBox {
                    HeadingView(headingImage: "photo", headingText: "Gallery of skins")
                    GunSkinsView(guns: gun)
                }
                
            }
        }
        .padding(.horizontal, 20)
        .navigationTitle("Learn about \(gun.displayName ?? "")")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - PREVIEW
#Preview {
    GunDetailView(gun: GunInfo.previewGun)
}
