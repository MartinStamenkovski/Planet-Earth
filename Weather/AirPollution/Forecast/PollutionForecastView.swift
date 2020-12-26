//
//  PollutionForecastView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 26.12.20.
//

import SwiftUI
import OpenWeatherAPI

struct PollutionForecastView: View {
    
    let pollution: Pollution
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pollution Forecast")
                .font(.system(size: 13, weight: .medium))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(pollution.pollutionElements, id: \.id) { element in
                        ForecastRow(pollutionElement: element)
                            .frame(width: 130)
                    }
                }
                .frame(minHeight: 0, maxHeight: .infinity)
                .padding(.horizontal, 12)
            }.frame(height: 120)
        }
        .padding(.vertical, 8)
    }
}
