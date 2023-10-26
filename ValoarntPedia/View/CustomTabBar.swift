//
//  Home.swift
//  ValoarntPedia
//
//  Created by Marcin Dytko on 08/09/2023.
//

import SwiftUI

enum TabItem: String, CaseIterable {
    case house, map, book, gearshape
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: TabItem
    @State var tabPoints: [CGFloat] = []
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.self) { item in
                TabBarButton(tabItem: item, selectedTab: $selectedTab, tabPoints: $tabPoints)
            }
        }
        .background(
            Color.blue
                .clipShape(TabCurve(tabPoint: getCruvePoints() - 15))
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
    func getCruvePoints() -> CGFloat {
        if tabPoints.isEmpty {
            return 10
        } else {
            switch selectedTab {
            case .house:
                return tabPoints[0]
            case .map:
                return tabPoints[1]
            case .book:
                return tabPoints[2]
            default:
                return tabPoints[3]
            }
        }
    }
}

struct CoustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
    }
}

struct TabBarButton: View {
    var tabItem: TabItem
    @Binding var selectedTab: TabItem
    @Binding var tabPoints: [CGFloat]
    
    var body: some View {
        GeometryReader { geo -> AnyView in
            let midX = geo.frame(in: .global).midX
            
            DispatchQueue.main.async {
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
                Button(action: {
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
                        selectedTab = tabItem
                    }
                    
                }, label: {
                    
                    Image(systemName: "\(tabItem)\(selectedTab == tabItem ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.cyan)
                        .offset(y: selectedTab == tabItem ? -10 : 0)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        .frame(height: 70)
    }
}
