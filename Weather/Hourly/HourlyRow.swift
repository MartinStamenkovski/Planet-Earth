//
//  HourlyRow.swift
//  Weather
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import SwiftUI
import OpenWeatherAPI
import KingfisherSwiftUI

struct HourlyRow: View {
    let hourly: Current
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(hourly.dateTime.hour)")
                .font(.system(size: 15))
                .foregroundColor(Color(.secondaryLabel))
            VStack {
                KFImage(.imageURL(name: hourly.iconName))
                    .cancelOnDisappear(true)
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("\(hourly.temperature.unitTemperature())")
                    .font(.system(size: 15))
                    .foregroundColor(Color(.secondaryLabel))
            }
        }.padding(8)
    }
}
