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
import Helpers
import PEMapView
import CoreLocation
import MapKit


public struct WeatherView: View {
    
    @ObservedObject var weatherService = OpenWeatherService<Weather>(endPoint: .weather)
    
    @State private var showCities = false
    
    public init() { }
    
    public var body: some View {
        VStack {
            if showCities {
                SavedCitiesView(currentLocation: self.weatherService.currentLocation) { placemark in
                    withAnimation(Animation.easeInOut(duration: 0.3)) {
                        self.showCities = false
                        self.weatherService.fetchWeather(for: placemark, delay: 0.35)
                    }
                }.transition(.move(edge: .bottom))
            } else {
                contentView().transition(.insertTopRemoveTopFade)
            }
        }
    }
    
    func contentView() -> AnyView {
        switch weatherService.state {
        case .success(let weather):
            return configureScrollView(for: weather)
        case .error(let error):
            return self.showErrorView(for: error)
        case .loading:
            return ActivityIndicator(.constant(true), color: .systemBlue)
                .transition(.scale)
                .toAnyView()
        }
        
    }
    
    func configureScrollView(for weather: Weather) -> AnyView {
        return VStack(spacing: 0) {
            WeatherHeaderView(placemark: weatherService.selectedPlacemark, weather: weather, showCities: $showCities)
            Divider().edgesIgnoringSafeArea(.all)
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
                MapWeatherView(region: .constant(weather.region))
                Divider()
            }
        }.toAnyView()
    }
    
    
    private func showErrorView(for error: PEError) -> AnyView  {
        NavigationView {
            PEErrorView(error: error) {
                self.weatherService.retryWeatherRequest()
            }
            .navigationBarItems(trailing: trailingBarItems())
        }.toAnyView()
    }
    
    private func trailingBarItems() -> some View {
        return Button {
           withAnimation(Animation.easeInOut(duration: 0.3)) {
               self.showCities = true
           }
       } label: {
           Image(systemName: "building.2.crop.circle")
               .font(.system(size: 22))
       }.toAnyView()
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
