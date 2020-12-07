//
//  Weather.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import Foundation

// MARK: - Weather
public struct Weather: Codable {
    
    public let latitude: Double
    public let longitude: Double
    public let timezone: String
    public let timezoneOffset: Int
    
    public let current: Current
    public let hourly: [Current]
    public let daily: [DailyWeather]

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
    
    public var iconName: String? {
        return self.current.iconName
    }
    
    public var mainDescription: String? {
        return self.current.mainDescription
    }
    
    public var sunRise: Int? {
        return self.current.sunrise
    }
    
    public var sunSet: Int? {
        return self.current.sunset
    }
}

// MARK: - Current
public struct Current: Codable, Identifiable {
    
    public let id = UUID()
    
    public let dateTime: Int
    public let sunrise, sunset: Int?
    public let temperature, feelsLike: Double
    public let pressure, humidity: Double
    public let dewPoint, uvi: Double
    public let clouds, visibility: Double
    public let windSpeed: Double
    public let windDegrees: Double
    public let weather: [WeatherElement]
    public let pop: Double?
    public let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case temperature = "temp"
        case sunrise, sunset
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDegrees = "wind_deg"
        case weather, pop, rain
    }
    
    public var iconName: String? {
        return self.weather.first?.icon
    }
    
    public var mainDescription: String? {
        return self.weather.first?.main
    }
 
}

// MARK: - Rain
public struct Rain: Codable {
    public let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

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

