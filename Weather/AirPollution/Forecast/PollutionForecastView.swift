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
        VStack(alignment: .leading, spacing: 8) {
            Text("Pollution Forecast")
                .font(.system(size: 13, weight: .medium))
                .padding(.bottom, 8)
                .padding(.horizontal, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(pollution.pollutionElements.filter({TimeInterval($0.dateTime) > Date().timeIntervalSince1970}), id: \.id) { element in
                        ForecastRow(pollutionElement: element)
                            .frame(width: 130)
                    }
                }
                .frame(minHeight: 0, maxHeight: .infinity)
                .padding(.horizontal, 12)
            }.frame(height: 100)
        }
        .padding(.vertical, 8)
    }
}
