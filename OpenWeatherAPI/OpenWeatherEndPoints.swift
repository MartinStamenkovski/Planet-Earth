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
    
    var url: URL {
        return .baseURL(with: self.rawValue)
    }
}

@frozen
public enum OpenWeatherIconSize: String {
    case x2 = "2x"
    case x4 = "4x"
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
