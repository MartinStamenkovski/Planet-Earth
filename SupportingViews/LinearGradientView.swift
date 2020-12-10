//
//  LinearGradientView.swift
//  SupportingViews
//
//  Created by Martin Stamenkovski on 10.12.20.
//

import SwiftUI

public struct LinearGradientView: View {
    
    let colors: [Color]
    let radius: CGFloat
    
    public init(colors: [Color], radius: CGFloat) {
        self.colors = colors
        self.radius = radius
    }
    
    public var body: some View {
    
        let gradient = Gradient(colors: colors)
        let linearGradient = LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
        
        let background = Rectangle()
            .fill(linearGradient)
            .blur(radius: radius, opaque: true)
            .edgesIgnoringSafeArea(.all)
        
        return background
    }
}
