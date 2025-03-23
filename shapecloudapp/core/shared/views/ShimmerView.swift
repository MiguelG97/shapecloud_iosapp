//
//  ShimmerView.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 22/03/25.
//

import SwiftUI

struct ShimmerView: View {
    @State private var startPoint: UnitPoint = .topLeading
    @State private var endPoint: UnitPoint = .bottomTrailing

    @State var cornerRadius : CGFloat = 8
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color(red: 224/255, green: 224/255, blue: 224/255), Color(red: 245/255, green: 245/255, blue: 245/255), Color(red: 224/255, green: 224/255, blue: 224/255)]),
            startPoint: startPoint,
            endPoint: endPoint
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                self.startPoint = UnitPoint(x: 1, y: 1)
                self.endPoint = UnitPoint(x: 2, y: 2)
            }
        }
    }
}

#Preview {
    ShimmerView()
}
