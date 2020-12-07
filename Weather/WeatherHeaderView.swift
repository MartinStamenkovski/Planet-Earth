//
//  WeatherHeaderView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 7.12.20.
//

import SwiftUI
import OpenWeatherAPI
import Extensions

struct WeatherHeaderView: View {
    let weather: Weather
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(weather.timezone)")
                .font(.system(size: 22, weight: .semibold))
            if let main = weather.mainDescription {
                Text(main)
                    .font(.system(size: 17, weight: .light))
            }
        }.padding(6)
    }
}
