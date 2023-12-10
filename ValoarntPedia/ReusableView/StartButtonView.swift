//
//  StartButtonView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 07/09/2023.
//

import SwiftUI

import SwiftUI

struct StartButtonView: View {
    let action: () -> Void
    
    // MARK: - BODY
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 8) {
                Text("Start")
                
                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule().strokeBorder(Color.white, lineWidth: 1.25)
            )
        }
        .accentColor(.white)
    }
}

// MARK: - PREVIEW
struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView {}
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
