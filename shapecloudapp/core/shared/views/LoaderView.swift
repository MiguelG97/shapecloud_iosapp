//
//  LoaderView.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 3/02/25.
//

import SwiftUI

struct LoaderView: View {
    @State private var fillUnit: Double = 0
    var ringColor : Color = Color.white
    var ringWidth : Double = 5
    
    private var animation : Animation {
        Animation.linear(duration: 1).repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Ring(fillUnit: fillUnit)
            .stroke(ringColor, lineWidth: ringWidth)
            .frame(width: 60, height: 60)
            .animation(animation, value: fillUnit)
            .onAppear {
                withAnimation {
                    fillUnit=1;
                }
            }
    }
}

struct Ring: Shape {
    var fillUnit : Double = 0
    var offset: Double = 60
    
    //    Interesting: RESERVED PROPERTY TO DESCRIBE HOW TO ANIMATE ANOTHER PROPERTY OF THE VIEW
    var animatableData: Double {
        get {fillUnit}
        set(newValue) {
            fillUnit=newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let filled = fillUnit * 360
        let end:Double = filled
        let start: Double = end - offset
        
        var path = Path()
        path.addArc(center: .init(x: rect.midX, y: rect.midY), radius: rect.midX, startAngle: .degrees(start), endAngle: .degrees(end), clockwise: false)
        
        return path
    }
}

#Preview {
    LoaderView()
}
