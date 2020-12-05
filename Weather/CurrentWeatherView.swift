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
        VStack(alignment: .center, spacing: 30) {
            VStack(spacing: 8) {
                Text("\(weather.timezone)")
                    .font(.system(size: 22, weight: .semibold))
                if let main = weather.mainDescription {
                    Text(main)
                        .font(.system(size: 17, weight: .light))
                }
            }
            HStack(spacing: 12) {
                KFImage(.weatherIcon(name: weather.iconName))
                    .cancelOnDisappear(true)
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("\(weather.current.temperature.unitTemperature())")
                    .font(.system(size: 70))
            }
        }.padding()
    }
}

