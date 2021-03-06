//
//  ForecastRow.swift
//  Weather
//
//  Created by Martin Stamenkovski on 26.12.20.
//

import SwiftUI
import OpenWeatherAPI

struct ForecastRow: View {
    
    let pollutionElement: PollutionElement
    
    var body: some View {
        VStack {
            Text("\(pollutionElement.dateTime.toDateShort)")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.black)
            Spacer()
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Text("PM10:")
                        .font(.system(size: 13))
                        .foregroundColor(.black)
                    Text("\(pollutionElement.components[.pm10] ?? 0.0, specifier: "%.1f")")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black)
                }
                HStack(spacing: 4) {
                    Text("PM2.5:")
                        .font(.system(size: 13))
                        .foregroundColor(.black)
                    Text("\(pollutionElement.components[.pm25] ?? 0.0, specifier: "%.1f")")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black)
                }
            }
            Spacer()
            Text(pollutionElement.main.aqiDescription)
                .font(.system(size: 12, weight: .heavy))
                .foregroundColor(.black)
        }
        .padding(8)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(pollutionElement.main.aqi.color)
        .cornerRadius(12)
    }
}
