//
//  LineView.swift
//  Helpers
//
//  Created by Martin Stamenkovski on 26.12.20.
//

import SwiftUI

public struct LineView: Shape {
    
    public init() { }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
    
}
