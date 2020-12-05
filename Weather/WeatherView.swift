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

public struct WeatherView: View {
    
    @ObservedObject var weatherService = OpenWeatherService(endPoint: .weather)
    
    public init() { }
    
    public var body: some View {
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
            return ScrollView(.vertical, showsIndicators: false) {
                CurrentWeatherView(weather: weather)
                HPWindView(weather: weather.current)
                Divider()
                HourlyWeatherView(hourly: weather.hourly)
                Divider()
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
