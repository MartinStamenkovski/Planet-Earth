//
//  UVIndexView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 6.12.20.
//

import SwiftUI
import OpenWeatherAPI
import Extensions

struct UVIndexView: View {
    
    let weather: Current
    
    var body: some View {
        Divider()
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                Image(systemName: "sun.max")
                    .font(.system(size: 25))
                    .foregroundColor(Color.orange)
                HStack(spacing: 0) {
                    Text("\(weather.uvi, specifier: "%.1f") ")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color.uvIndexColor(for: weather.uvi))
                    Text("UV Index")
                        .font(.system(size: 20))
                        .foregroundColor(Color(.label).opacity(0.8))
                }
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text(weather.uviProtection)
                .font(.system(size: 10, weight: .medium))
        }.padding(8)
        Divider()
    }
}
