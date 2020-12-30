//
//  DailyRow.swift
//  Weather
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import SwiftUI
import KingfisherSwiftUI
import OpenWeatherAPI

struct DailyRow: View {
    
    let weather: DailyWeather
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text(weather.dateTime.relativeDate)
                .font(.system(size: 17))
            Spacer()
            DailyTemperatureView(weather: weather)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
    }
}

struct DailyTemperatureView: View {
    let weather: DailyWeather
    
    var body: some View {
        HStack(spacing: 20) {
            KFImage(.weatherIcon(name: weather.iconName, size: .x4))
                .cancelOnDisappear(true)
                .resizable()
                .frame(width: 40, height: 40)
                .modifier(WeatherIconBackground())
            HStack(spacing: 12) {
                Text("\(weather.dailyTemperature.max.unitTemperature)")
                    .frame(minWidth: 35, alignment: .center)
                    .foregroundColor(Color(.label))
                Text("\(weather.dailyTemperature.min.unitTemperature)")
                    .frame(minWidth: 35, alignment: .center)
                    .foregroundColor(Color(.label).opacity(0.7))
            }
        }.padding(4)
    }
}


