//
//  WeatherView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import SwiftUI
import OpenWeatherAPI
import KingfisherSwiftUI
import Extensions

enum WeatherRow: Int, CaseIterable {
    case current = 0
    case hourly
    case daily
    case sunInfo
    case uvIndex
}

public struct WeatherView: View {
    
    @ObservedObject var weatherService = OpenWeatherService(endPoint: .weather)
        
    public init() { }
    
    public var body: some View {
        contentView()
    }
    
    func contentView() -> AnyView {
        switch weatherService.state {
        case .success:
            return mainScrollView()
        case .error(let error):
            return Text(error.localizedDescription).toAnyView()
        default:
            return Text("Loading").toAnyView()
        }
    }
    
    func mainScrollView() -> AnyView {
        if let weather = self.weatherService.weather {
            return VStack(spacing: 0) {
                WeatherHeaderView(weather: weather)
                Divider()
                ScrollView(showsIndicators: false) {
                    CurrentWeatherView(weather: weather)
                    Group {
                        HourlyWeatherView(hourly: weather.hourly)
                        Divider()
                        DailyWeatherView(daily: weather.daily)
                        Divider()
                        SunInfoView(sunRise: weather.sunRise?.hourMedium, sunSet: weather.sunSet?.hourMedium)
                    }
                    UVIndexView(weather: weather.current)
                }
            }.toAnyView()
        } else {
            return Text("No data available").toAnyView()
        }
    }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
