//
//  ActivityIndicator.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 23.11.20.
//

import SwiftUI

public struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    var color: UIColor
    
    public init(_ isAnimating: Binding<Bool>, color: UIColor) {
        self._isAnimating = isAnimating
        self.color = color
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = color
        return indicatorView
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        self.isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
