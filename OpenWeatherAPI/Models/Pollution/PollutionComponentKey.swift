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
    
    public var wikiURL: URL {
        switch self {
        case .co:
            return self.wikiURL(for: "Carbon_monoxide")
        case .no:
            return self.wikiURL(for: "Nitric_oxide")
        case .no2:
            return self.wikiURL(for: "Nitrogen_dioxide")
        case .o3:
            return self.wikiURL(for: "Ozone")
        case .so2:
            return self.wikiURL(for: "Sulfur_dioxide")
        case .pm25:
            return self.wikiURL(for: "Particulates")
        case .pm10:
            return self.wikiURL(for: "Particulates#Size,_shape_and_solubility_matter")
        case .nh3:
            return self.wikiURL(for: "Ammonia")
        }
    }
    
    func wikiURL(for key: String) -> URL {
        return URL(string: "https://en.wikipedia.org/wiki/\(key)")!
    }
}

public extension Dictionary where Key == String, Value == Double {
    
    subscript(_ key: PollutionComponentKey) -> Value? {
        return self[key.rawValue]
    }
    
}
