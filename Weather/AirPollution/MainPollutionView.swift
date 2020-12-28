//
//  MainPollutionView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 20.12.20.
//

import SwiftUI
import Extensions
import Helpers
import OpenWeatherAPI

struct MainPollutionView: View {
    
    let pollution: PollutionElement
    let placemark: Placemark?
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(spacing: 8) {
                Text("\(placemark?.thoroughfare ?? placemark?.name ?? "N/A")")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.black)
                    .padding(4)
                Divider()
                VStack(spacing: 6) {
                    Text("Air Quality")
                        .foregroundColor(Color(.darkGray))
                    Text(pollution.main.aqiDescription.uppercased())
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundColor(.black)
                }.padding(8)
            }
            .padding(8)
            .background(pollution.main.aqi.color)
            .cornerRadius(12)
            
            VStack {
                Text("\(pollution.main.aqi.precautions)")
                    .font(.system(size: 15))
                Divider()
                Text("\(pollution.dateTime.toDateMedium)")
                    .font(.system(size: 15))
                    .foregroundColor(Color(.secondaryLabel))
                    
            }.padding(8)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding()
        .clipped()
        .shadow(color: Color.gray.opacity(0.6), radius: 4)
    }
}

