//
//  WeatherElement.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 22.12.20.
//

import Foundation


// MARK: - WeatherElement
public struct WeatherElement: Codable {
    public let id: Int
    public let main: String
    public let weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
