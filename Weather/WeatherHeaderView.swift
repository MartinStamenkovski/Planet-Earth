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
    let city: String?
    let weather: Weather
    @Binding var showCities: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Spacer()
                VStack(spacing: 6) {
                    Text(city ?? "")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    if let main = weather.mainDescription {
                        Text(main)
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.white)
                    }
                }.padding(.trailing, -20)
                Spacer()
                Button {
                    withAnimation(Animation.easeInOut(duration: 0.2)) {
                        self.showCities = true
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal, 8)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(6)
    }
}
