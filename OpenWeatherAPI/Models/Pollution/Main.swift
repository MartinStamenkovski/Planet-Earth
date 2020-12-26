//
//  Main.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 22.12.20.
//

import Foundation
import SwiftUI

// MARK: - Main
public struct Main: Codable {
    public let aqi: AQI
    
    public var aqiDescription: String {
        return self.aqi.stringDescription
    }
}

@frozen
public enum AQI: Int, Codable {
    case good = 1
    case fair
    case moderate
    case poor
    case veryPoor
    
    public var stringDescription: String {
        switch self {
        case .good:
            return "Very Good"
        case .fair:
            return "Fair"
        case .moderate:
            return "Moderate"
        case .poor:
            return "Very Unhealthy"
        case .veryPoor:
            return "Hazardous"
        }
    }
    
    public var color: Color {
        switch self {
        case .good:
            return Color(.init(red: 162/255, green: 217/255, blue: 103/255, alpha: 1))
        case .fair:
            return Color(.init(red: 249/255, green: 212/255, blue: 92/255, alpha: 1))
        case .moderate:
            return Color(.init(red: 250/255, green: 153/255, blue: 93/255, alpha: 1))
        case .poor:
            return Color(.init(red: 251/255, green: 107/255, blue: 113/255, alpha: 1))
        case .veryPoor:
            return Color(.init(red: 167/255, green: 124/255, blue: 186/255, alpha: 1))
        }
    }
}
