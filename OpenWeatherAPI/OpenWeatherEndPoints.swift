//
//  OpenWeatherEndPoints.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 4.12.20.
//

import Foundation

@frozen
public enum OpenWeatherEndPoints: String {
    
    case weather = "onecall"
    
    case airPollution = "air_pollution"
    case airPollutionForecast = "air_pollution/forecast"
    
    var url: URL {
        return .baseURL(with: self.rawValue)
    }
    
}


extension URL {
    
    static func baseURL(with part: String) -> URL {
        return URL(string: "http://api.openweathermap.org/data/2.5/\(part)")!
    }
    
    public static func weatherIcon(name: String?, size: OpenWeatherIconSize = .x2) -> URL? {
        guard let iconName = name else { return nil }
        return URL(string: "http://openweathermap.org/img/wn/\(iconName)@\(size.rawValue).png")!
    }
    
}
