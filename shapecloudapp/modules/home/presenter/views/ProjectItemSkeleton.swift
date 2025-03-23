//
//  ProjectItemSkeleton.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 18/03/25.
//

import SwiftUI

struct ProjectItemSkeleton: View {
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    ShimmerView(cornerRadius: 25)
                        .frame(width: 50,height: 50)
                    
                    VStack(spacing:8) {
                        ShimmerView()
                            .frame(height:20)
                            .fontWeight(.semibold)
                        
                        ShimmerView()
                            .frame(height:20)
                    }
                }
                .padding(.bottom,8)
                
                ShimmerView()
                    .frame(height:20)
            }
            .padding(.horizontal,12)
            .padding(.vertical,12)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.theme.foreground_muted,lineWidth: 0.6)
            }
            
            ShimmerView()
                .frame(height: 20)
                .padding(.horizontal,12)
                .padding(.bottom,4)
        }
        .padding(6)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.theme.foreground_muted,lineWidth: 0.6)
        }
    }
}

#Preview {
    ProjectItemSkeleton()
}
