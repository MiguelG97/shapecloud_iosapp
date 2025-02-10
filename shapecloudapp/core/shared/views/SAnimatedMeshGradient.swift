//
//  SAnimatedMeshGradient.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 9/02/25.
//

import SwiftUI

class PerlinNoise {
    private let permutation: [Int]
    
    init(seed: Int = 42) {
        var generator = SeededGenerator(seed: seed)
        var perm = Array(0...255)
        perm.shuffle(using: &generator)
        self.permutation = perm + perm
    }

    func noise(x: Double) -> Double {
        let xi = Int(x) & 255
        let xf = x - floor(x)
        
        let u = fade(xf)
        let grad1 = grad(permutation[xi], xf)
        let grad2 = grad(permutation[xi + 1], xf - 1)
        
        return lerp(u, grad1, grad2)
    }

    private func fade(_ t: Double) -> Double {
        return t * t * t * (t * (t * 6 - 15) + 10)
    }

    private func lerp(_ t: Double, _ a: Double, _ b: Double) -> Double {
        return a + t * (b - a)
    }

    private func grad(_ hash: Int, _ x: Double) -> Double {
        return (hash & 1) == 0 ? x : -x
    }
}
struct SeededGenerator: RandomNumberGenerator {
    init(seed: Int) {
        self.state = UInt64(seed)
    }

    private var state: UInt64

    mutating func next() -> UInt64 {
        state = state &* 6364136223846793005 &+ 1
        return state
    }
}


struct SAnimatedMeshGradient: View {
    @State private var offset: Double = 0.0
    private let perlin = PerlinNoise()
    
    
    var body: some View {
        MeshGradient(width: 3, height: 3, points: [
            .init(0, 0),
            .init(Float(perlinValue(offset*1.5)), 0),
            .init(1, 0),
            .init(0, 0.1 + Float(perlinValue(offset+1)))*0.8,
            .init(0.2 + Float(perlinValue(offset)), 0.3 + Float(perlinValue(offset+0.5))*0.8),
                .init(1, 0.5),
            .init(0, 1),
            .init(0.5, 1),
            .init(1, 1)
        ], colors: [
            Color(red: 17/255, green: 34/255, blue: 96/255),
            .theme.primary,
            Color(red: 17/255, green: 34/255, blue: 96/255),
            .theme.primary,
            Color(red: 35/255, green: 48/255, blue: 65/255),
            .theme.primary,
            Color(red: 17/255, green: 34/255, blue: 96/255),
            .theme.primary,
            Color(red: 17/255, green: 34/255, blue: 96/255),
        ])
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                offset += 0.02
//                print(perlinValue(offset+1))
            }
            
        }
        
    }
    
    private func perlinValue(_ x: Double) -> Double {
        perlin.noise(x: x) * 0.5 + 0.5 // Normalize values to 0.0 - 1.0
    }
}

#Preview {
    SAnimatedMeshGradient()
}
