//
//  GasRow.swift
//  Weather
//
//  Created by Martin Stamenkovski on 26.12.20.
//

import SwiftUI
import Helpers
import OpenWeatherAPI

struct GasRow: View {
    let gasType: String
    let gasValue: Double
    
    @State private var showSafari = false
    
    var body: some View {
        HStack(spacing: 12) {
            Text(gasType.replacingOccurrences(of: "_", with: ".").uppercased())
                .font(.system(size: 17, weight: .medium))
            Spacer()
            HStack(spacing: 6) {
                Text("\(gasValue, specifier: "%.2f")")
                    .font(.system(size: 17, weight: .heavy))
                Text("μg/m3")
                    .font(.system(size: 17))
            }
            Button {
                self.showSafari = true
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 20))
            }
        }
        .padding(8)
        .sheet(isPresented: $showSafari) {
            if let url = PollutionComponentKey(rawValue: gasType)?.wikiURL {
                SFSafariView(url: url)
            }
        }
    }
}

struct GasRow_Previews: PreviewProvider {
    static var previews: some View {
        GasRow(gasType: "PM 10", gasValue: 2)
    }
}
