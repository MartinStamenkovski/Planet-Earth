//
//  DailyWeatherView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import SwiftUI
import OpenWeatherAPI

struct DailyWeatherView: View {
    let daily: [DailyWeather]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(daily, id: \.id) { weather in
                DailyRow(weather: weather)
            }
        }
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(daily: [])
    }
}
