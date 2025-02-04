//
//  SLine.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 4/02/25.
//

import SwiftUI
struct SLine: View {
    
    var linewidth : Double = 16
    var lineThichkness : Double = 1
    
    var body: some View{
        Path {  path in
            path.move(to: CGPoint(x: 0, y: 10))
            path.addLine(to: CGPoint(x: linewidth, y: 10))
        }
        .stroke(Color.black, lineWidth: lineThichkness)
        .frame(width: linewidth,height: 20)
    }
    
}

#Preview {
    SLine()
}
