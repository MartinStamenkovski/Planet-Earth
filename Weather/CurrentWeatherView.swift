//
//  WeatherCurrentView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import SwiftUI
import OpenWeatherAPI
import KingfisherSwiftUI

struct CurrentWeatherView: View {
    var weather: Weather
    
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            HStack(alignment: .center, spacing: 12) {
                KFImage(.weatherIcon(name: weather.iconName))
                    .cancelOnDisappear(true)
                    .resizable()
                    .frame(width: 90, height: 90)
                Text("\(weather.current.temperature.unitTemperature)")
                    .font(.system(size: 60))
            }
            HPWindView(weather: weather.current)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        Divider()
    }
}

