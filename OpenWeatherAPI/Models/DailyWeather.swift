//
//  DailyWeather.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import Foundation

// MARK: - Daily
public struct DailyWeather: Codable, Identifiable {
    
    public let id = UUID()
    
    public let dateTime, sunrise, sunset: Int
    public let dailyTemperature: DailyTemperature
    public let feelsLike: FeelsLike
    public let pressure, humidity: Double
    public let dewPoint, windSpeed: Double
    public let windDegree: Double
    public let weather: [WeatherElement]
    public let clouds: Double
    public let pop, uvi: Double
    public let rain: Double?

    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case sunrise, sunset
        case dailyTemperature = "temp"
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDegree = "wind_deg"
        case weather, clouds, pop, uvi, rain
    }
    
    public var iconName: String? {
        return self.weather.first?.icon
    }
}

// MARK: - FeelsLike
public struct FeelsLike: Codable {
    public let day, night, eve, morn: Double
}

// MARK: - Temp
public struct DailyTemperature: Codable {
    public let day, min, max, night: Double
    public let eve, morn: Double
}
