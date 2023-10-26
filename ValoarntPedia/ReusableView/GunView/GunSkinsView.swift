//
//  GunSkinsView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 03/10/2023.
//

import SwiftUI

struct GunSkinsView: View {
    // MARK: - PROPERTIES
    
    let guns: GunInfo
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center , spacing: 15) {
                ForEach(guns.skins) { skin in
                    if let skinLink = skin.displayIcon {
                        AsyncImage(url: URL(string: skinLink)!) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300)
                                .cornerRadius(12)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    GunSkinsView(guns: GunInfo.previewGun)
}
