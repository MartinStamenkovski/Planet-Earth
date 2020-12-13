//
//  Weather.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import Foundation
import MapKit
import CoreLocation

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
    
    public var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 2.5489, longitudeDelta: 3.4098))
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
    
    public var uviProtection: String {
        switch self.uvi {
        case 0.0..<3.0:
            return """
            A UV index reading of 0 to 2 means low danger from the Sun's UV rays for the average person.

            Wear sunglasses on bright days. If you burn easily, cover up and use broad spectrum SPF 30+ sunscreen. Bright surfaces, sand, water, and snow, will increase UV exposure.
            """
        case 3.0..<6.0:
            return """
                A UV index reading of 3 to 5 means moderate risk of harm from unprotected sun exposure.

                Stay in shade near midday when the Sun is strongest. If outdoors, wear sun-protective clothing, a wide-brimmed hat, and UV-blocking sunglasses. Generously apply broad spectrum SPF 30+ sunscreen every 1.5 hours, even on cloudy days, and after swimming or sweating. Bright surfaces, such as sand, water, and snow, will increase UV exposure.
                """
        case 6.0..<8.0:
            return """
                A UV index reading of 6 to 7 means high risk of harm from unprotected sun exposure. Protection against skin and eye damage is needed.

                Reduce time in the sun between 10 a.m. and 4 p.m. If outdoors, seek shade and wear sun-protective clothing, a wide-brimmed hat, and UV-blocking sunglasses. Generously apply broad spectrum SPF 30+ sunscreen every 1.5 hours, even on cloudy days, and after swimming or sweating. Bright surfaces, such as sand, water, and snow, will increase UV exposure.
                """
        case 8.0..<10.0:
            return """
                A UV index reading of 8 to 10 means very high risk of harm from unprotected sun exposure. Take extra precautions because unprotected skin and eyes will be damaged and can burn quickly.

                Minimize sun exposure between 10 a.m. and 4 p.m. If outdoors, seek shade and wear sun-protective clothing, a wide-brimmed hat, and UV-blocking sunglasses. Generously apply broad spectrum SPF 30+ sunscreen every 1.5 hours, even on cloudy days, and after swimming or sweating. Bright surfaces, such as sand, water, and snow, will increase UV exposure.
                """
        default:
            return """
                A UV index reading of 11 or more means extreme risk of harm from unprotected sun exposure. Take all precautions because unprotected skin and eyes can burn in minutes.

                Try to avoid sun exposure between 10 a.m. and 4 p.m. If outdoors, seek shade and wear sun-protective clothing, a wide-brimmed hat, and UV-blocking sunglasses. Generously apply broad spectrum SPF 30+ sunscreen every 1.5 hours, even on cloudy days, and after swimming or sweating. Bright surfaces, such as sand, water, and snow, will increase UV exposure.
                """
        }
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

