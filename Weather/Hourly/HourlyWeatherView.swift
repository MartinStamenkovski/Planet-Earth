//
//  HourlyWeatherView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import SwiftUI
import OpenWeatherAPI
import KingfisherSwiftUI
import Extensions

struct HourlyWeatherView: View {
    var hourly: [Current]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(hourly, id: \.id) { hourly in
                        HourlyRow(hourly: hourly)
                    }
                }.frame(minHeight: 0, maxHeight: .infinity)
            }.frame(height: 100)
        }
    }
}

struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeatherView(hourly: [])
    }
}
