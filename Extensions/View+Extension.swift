//
//  View+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 29.11.20.
//

import SwiftUI

extension View {
    
    public func toAnyView() -> AnyView {
        return AnyView(self)
    }
    
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
