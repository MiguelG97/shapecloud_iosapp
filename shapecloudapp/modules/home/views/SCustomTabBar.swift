//
//  STabBarView.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 9/02/25.
//

import SwiftUI

struct SCustomTabBar: View {
    @Environment(\.screenSize) private var screenSize: CGSize
    @Binding var selectedTab: STab
    
    var isBarHidden : Bool = true
    
    private let tabBarHeight: Double = 106
    
    var body: some View {
        let h1: CGFloat = screenSize.width*0.35 //125
        let v1: CGFloat = screenSize.width*0.06
        let r1: CGFloat = screenSize.width * 0.042
        let r2: CGFloat = screenSize.width*0.095
        let h2: CGFloat = screenSize.width*0.025 // offset
        
        ZStack {
            
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: tabBarHeight))
                path.addLine(to: CGPoint(x: screenSize.width, y: tabBarHeight))
                path.addLine(to: CGPoint(x: screenSize.width, y: 0))
                path.addQuadCurve(to: CGPoint(x: (screenSize.width - h1), y: v1), control: CGPoint(x: screenSize.width - (h1 / 3), y: v1))
                path.addArc(center: CGPoint(x: screenSize.width - h1, y: v1 + r1), radius: r1, startAngle: .init(degrees: 360), endAngle: .init(degrees: -270), clockwise: true)
                path.addArc(center: CGPoint(x: screenSize.width - h1 - r1-r2, y: v1+r1), radius: r2, startAngle: .init(degrees: 0), endAngle: .init(degrees: 90), clockwise: false)
                path.addArc(center: CGPoint(x: screenSize.width - h1 - r1-r2-h2, y: v1+r1), radius: r2, startAngle: .init(degrees: 90), endAngle: .init(degrees: -180), clockwise: false)
                path.addArc(center: CGPoint(x: h1, y: v1+r1), radius: r1, startAngle: .degrees(0), endAngle: .degrees(-90), clockwise: true)
                path.addQuadCurve(to: CGPoint(x: 0, y: 0), control: CGPoint(x: h1/3, y: v1))
            }
            .fill(.white)
            .shadow(color:.black.opacity(0.1),radius: 10,x: 0,y: -5)
            .offset(y: isBarHidden ? tabBarHeight : 0)
            
            HStack {
                HStack(spacing:screenSize.width*0.1) {
                    Image(systemName: "house")
                    Image(systemName: "magnifyingglass")
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                
                Spacer()
                
                HStack(spacing:screenSize.width*0.1) {
                    Image(systemName: "questionmark.circle")
                    Image(systemName: "person")
                }
                .frame(maxWidth:.infinity,alignment: .trailing)
            }
            .padding(.horizontal,   screenSize.width*0.077)
            .foregroundStyle(Color.theme.icon)
            .font(.system(size: 24))
            .offset(y: isBarHidden ? tabBarHeight : 5)
            
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
                    .font(.system(size: 24))
                    .padding(r2*0.5)
                    .background(Color.theme.primary)
                    .clipShape(.circle)
                    .shadow(color: Color.theme.primary.opacity(0.8), radius: 10, x: 0, y: 5)
                    
            }
            .frame(maxWidth: .infinity,alignment: isBarHidden ? .trailing: .center)
            .offset(x:isBarHidden ? -16 : 0,y: -18)
            
        }
        .frame(maxWidth: .infinity,maxHeight: 106)
    }
}

#Preview {
    SCustomTabBar(selectedTab: .constant(.projects))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
}
