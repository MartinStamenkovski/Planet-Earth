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
    let timeZone: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(hourly.dateTime.hour(timeZone: timeZone))")
                .font(.system(size: 15))
                .foregroundColor(Color.white.opacity(0.8))
            VStack {
                KFImage(.weatherIcon(name: hourly.iconName))
                    .cancelOnDisappear(true)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.white)
                Text("\(hourly.temperature.unitTemperature)")
                    .font(.system(size: 15))
                    .foregroundColor(Color.white)
            }
        }.padding(8)
    }
}
