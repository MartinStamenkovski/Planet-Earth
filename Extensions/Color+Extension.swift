//
//  Color+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 7.12.20.
//

import SwiftUI

extension Color {
    
    public static func uvIndexColor(for uvi: Double) -> Color {
        switch uvi {
        case 0..<3:
            return Color(.systemGreen)
        case 3..<6:
            return Color(.uvModerate)
        case 6..<8:
            return Color(.uvHigh)
        case 8...10:
            return Color(.uvVeryHigh)
        default:
            return Color(.uvExtreme)
        }
    }
}
