//
//  OpenWeatherEndPoints.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 4.12.20.
//

import Foundation

@frozen
public enum OpenWeatherEndPoints: String {
    case uvIndex = "uvi"
    case weather = "onecall"
    
    var url: URL {
        return .baseURL(with: self.rawValue)
    }
}

extension URL {
    static func baseURL(with part: String) -> URL {
        return URL(string: "http://api.openweathermap.org/data/2.5/\(part)")!
    }
    
    public static func weatherIcon(name: String?) -> URL? {
        guard let iconName = name else { return nil }
        return URL(string: "http://openweathermap.org/img/wn/\(iconName)@2x.png")!
    }
}
