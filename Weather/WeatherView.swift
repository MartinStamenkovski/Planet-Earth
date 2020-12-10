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
import SupportingViews

enum WeatherRow: Int, CaseIterable {
    case current = 0
    case hourly
    case daily
    case sunInfo
    case uvIndex
}

public struct WeatherView: View {
    
    @ObservedObject var weatherService = OpenWeatherService(endPoint: .weather)
    
    @State private var showCities = false
    
    public init() { }
    
    public var body: some View {
        ZStack {
            LinearGradientView(
                colors: [
                    Color(.sRGB, red: 78/255, green: 128/255, blue: 222/255, opacity: 1),
                    Color(.sRGB, red: 124/255, green: 169/255, blue: 240/255, opacity: 1),
                ],
                radius: 200
            ).edgesIgnoringSafeArea(.all)
            VStack {
                if showCities {
                    SavedCities { placemark in
                        withAnimation(Animation.easeOut(duration: 0.2)) {
                            self.showCities = false
                            self.weatherService.fetchWeather(for: placemark)
                        }
                    }.transition(.insertBottomRemoveTopFade)
                } else {
                    contentView().transition(.insertTopRemoveBottomFade)
                }
            }
        }
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
                WeatherHeaderView(city: weatherService.city, weather: weather, showCities: $showCities)
                Divider().edgesIgnoringSafeArea(.horizontal)
                ScrollView(showsIndicators: false) {
                    CurrentWeatherView(weather: weather)
                    Group {
                        HourlyWeatherView(hourly: weather.hourly, timeZone: weather.timezone)
                        Divider()
                        DailyWeatherView(daily: weather.daily)
                        Divider()
                        SunInfoView(
                            sunRise: weather.sunRise?.hourMedium(timeZone: weather.timezone),
                            sunSet: weather.sunSet?.hourMedium(timeZone: weather.timezone)
                        )
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

