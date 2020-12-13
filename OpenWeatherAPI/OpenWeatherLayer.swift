//
//  OpenWeatherLayer.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 13.12.20.
//

import Foundation

@frozen
public enum OpenWeatherLayer: String, CaseIterable {
    
    case temperature = "Temperature"
    case clouds = "Clouds"
    case wind = "Wind"
    case precipitation = "Precipitation"
    
    var identifier: String {
        switch self {
        case .temperature:
            return "temp_new"
        case .clouds:
            return "clouds_new"
        case .wind:
            return "wind_new"
        case .precipitation:
            return "precipitation_new"
        }
    }
    
    public var iconName: String {
        switch self {
        case .temperature:
            return "thermometer"
        case .clouds:
            return "cloud.fill"
        case .wind:
            return "wind"
        case .precipitation:
            return "cloud.heavyrain.fill"
        }
    }
}

extension URL {
    
    public static func openWeatherLayer(for type: OpenWeatherLayer, z: Int, x: Int, y: Int) -> Self {
        return URL(
            string: "https://tile.openweathermap.org/map/\(type.identifier)/\(z)/\(x)/\(y).png?appid=1401ad6496ff98b6401caab2e6cfa2d7"
        )!
    }
}
