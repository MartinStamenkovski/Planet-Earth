//
//  SunInfoView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 6.12.20.
//

import SwiftUI

struct SunInfoView: View {
    let sunRise: String?
    let sunSet: String?
    
    var body: some View {
        HStack {
            SunDetailView(title: "Sunrise", imageName: "sunrise", data: sunRise ?? "N/A")
                .frame(minWidth: 0, maxWidth: .infinity)
            SunDetailView(title: "Sunset", imageName: "sunset", data: sunSet ?? "N/A")
                .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

struct SunDetailView: View {
    let title: String
    let imageName: String
    let data: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
            Image(systemName: imageName)
                .font(.system(size: 25))
                .foregroundColor(Color.orange)
            Text(data)
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct SunInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SunInfoView(sunRise: "07:04:44 AM", sunSet: "07:04:44 AM")
    }
}
