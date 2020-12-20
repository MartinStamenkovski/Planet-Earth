//
//  HPWindView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import SwiftUI
import OpenWeatherAPI

struct HPWindView: View {
    let weather: Current
    
    var body: some View {
        HStack(spacing: 0) {
            SubDetailView(imageName: "drop", title: "Humidity", data: "\(weather.humidity)%")
                .frame(minWidth: 0, maxWidth: .infinity)
            
            SubDetailView(imageName: "barometer", title: "Pressure", data: "\(weather.pressure.unitPressure)")
                .frame(minWidth: 0, maxWidth: .infinity)
            
            SubDetailView(imageName: "wind", title: "Wind", data: "\(weather.windSpeed.unitSpeed)")
                .frame(minWidth: 0, maxWidth: .infinity)
            
            SubDetailView(imageName: "eye", title: "Visibility", data: "\(weather.visibility.unitLength)")
                .frame(minWidth: 0, maxWidth: .infinity)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.horizontal, 6)
    }
}
