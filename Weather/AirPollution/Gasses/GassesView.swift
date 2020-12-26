//
//  GassesView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 26.12.20.
//

import SwiftUI
import OpenWeatherAPI
import Helpers

struct GassesView: View {
    
    let gasses: [String: Double]
    
    var body: some View {
        VStack {
            ForEach(Array(gasses.keys).sorted(by: > ), id: \.self) { key in
                GasRow(gasType: key, gasValue: gasses[key] ?? 0.0)
                if key != Array(gasses.keys).sorted(by: > ).last {
                    LineView()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [6]))
                        .frame(height: 0.6)
                        .foregroundColor(Color(.secondarySystemFill))
                }
            }
        }
    }
    
}


struct GassesView_Previews: PreviewProvider {
    static var previews: some View {
        GassesView(gasses: [:])
    }
}
