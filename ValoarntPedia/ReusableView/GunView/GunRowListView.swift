//
//  GunRowListView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 01/10/2023.
//

import SwiftUI

struct GunRowListView: View {
    // MARK: - PROPERTIES
    
    let gun: GunInfo
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Image("valorant-backgorund")
                .resizable()
                .frame(width: 150, height: 200)
                .cornerRadius(20)
            
            ZStack {
   
                VStack {
                    AsyncImage(url: URL(string: gun.displayIcon ?? "")!) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(.degrees(55))
                            .frame(width: 120, height: 30)
                            .offset(y: 20)

                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(gun.displayName ?? "")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                        .offset(y: 40)
                }
        
            }
        }
    }
}

//// MARK: - PREVIEW
//#Preview {
//    GunRowListView(gun: GunInfo.previewGun)
//}
