//
//  PollutionComponentKey.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 22.12.20.
//

import Foundation

@frozen
public enum PollutionComponentKey: String, Codable {
    case co = "co"
    case no = "no"
    case no2 = "no2"
    case o3 = "o3"
    case so2 = "so2"
    case pm25 = "pm2_5"
    case pm10 = "pm10"
    case nh3 = "nh3"
}

public extension Dictionary where Key == String, Value == Double {
    
    subscript(_ key: PollutionComponentKey) -> Value? {
        return self[key.rawValue]
    }
    
}
