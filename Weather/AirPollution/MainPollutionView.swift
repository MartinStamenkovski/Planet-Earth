//
//  MainPollutionView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 20.12.20.
//

import SwiftUI
import OpenWeatherAPI
import Extensions

struct MainPollutionView: View {
    
    let pollution: PollutionElement
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(spacing: 8) {
                Text("Skopje")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .padding(4)
                Divider()
                VStack(spacing: 6) {
                    Text("Air Quality")
                        .foregroundColor(.white)
                    Text(pollution.main.aqiDescription.uppercased())
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundColor(.white)
                }.padding(8)
            }
            .padding(8)
            .background(pollution.main.aqi.color)
            .cornerRadius(12)
            
            Text("\(pollution.dateTime.toDateMedium)")
                .font(.system(size: 15))
                .padding(8)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding()
        .clipped()
        .shadow(color: Color.gray.opacity(0.6), radius: 4)
    }
}

