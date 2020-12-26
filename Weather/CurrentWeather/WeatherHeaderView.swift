//
//  WeatherHeaderView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 7.12.20.
//

import SwiftUI
import OpenWeatherAPI
import Extensions
import Helpers

struct WeatherHeaderView: View {
    
    let placemark: Placemark?
    let weather: Weather
    
    @Binding var showCities: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: nil) {
                Spacer()
                VStack(spacing: 6) {
                    Text(placemark?.name ?? "")
                        .lineLimit(1)
                        .font(.system(size: 20, weight: .semibold))
                    if let main = weather.mainDescription {
                        Text(main)
                            .font(.system(size: 12, weight: .light))
                    }
                }
                .padding(.trailing, 10)
                .padding(.leading, 32)
                Spacer()
                Button {
                    withAnimation(Animation.easeInOut(duration: 0.3)) {
                        self.showCities = true
                    }
                } label: {
                    Image(systemName: "building.2.crop.circle")
                        .resizable()
                        .frame(width: 22, height: 22, alignment: .top)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal, 10)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(6)
    }
}
