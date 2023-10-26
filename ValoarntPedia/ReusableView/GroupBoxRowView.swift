//
//  GroupBoxRowView.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 05/10/2023.
//

import SwiftUI

struct GroupBoxRowView: View {
    // MARK: - PROPETIES
    
    let textHeader: String
    let textValue: String
    
    // MARK: - BODY
    var body: some View {
        Divider()
            .padding(.vertical, 2)
        
        HStack {
            Group {
                Image(systemName: "info.circle")
                Text(textHeader)
            }
            .foregroundColor(.blue)
            .font(.system(.body).bold())
            
            Spacer(minLength: 25)
            Text(textValue)
                .multilineTextAlignment(.trailing)
        }
    }
}

// MARK: - PRVIEW
#Preview {
    GroupBoxRowView(textHeader: "daw", textValue: "wda")
}
