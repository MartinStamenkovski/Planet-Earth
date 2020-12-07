//
//  DailyRow.swift
//  Weather
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import SwiftUI
import KingfisherSwiftUI
import OpenWeatherAPI

struct DailyRow: View {
    
    let weather: DailyWeather
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text(weather.dateTime.relativeDate)
                .font(.system(size: 15))
            Spacer()
            DailyTemperatureView(weather: weather)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
    }
}

struct DailyTemperatureView: View {
    let weather: DailyWeather
    
    var body: some View {
        HStack(spacing: 20) {
            KFImage(.weatherIcon(name: weather.weather.first?.icon))
                .cancelOnDisappear(true)
                .resizable()
                .frame(width: 30, height: 30)
            HStack(spacing: 12) {
                Text("\(weather.dailyTemperature.max.unitTemperature)")
                    .foregroundColor(Color(.label))
                    .frame(minWidth: 30)
                Text("\(weather.dailyTemperature.max.unitTemperature)")
                    .foregroundColor(Color(.secondaryLabel))
                    .frame(minWidth: 30)
            }
        }
    }
}

//
//struct DailyRow_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyRow()
//    }
//}
