//
//  MapLayerTypeRow.swift
//  Weather
//
//  Created by Martin Stamenkovski on 13.12.20.
//

import SwiftUI
import OpenWeatherAPI

struct MapLayerTypeRow: View {
    
    let layerType: OpenWeatherLayer
    
    var body: some View {
        HStack {
            Image(systemName: layerType.iconName)
                .font(.system(size: 18))
            Text(layerType.rawValue)
                .fixedSize(horizontal: true, vertical: false)
        }
        .frame(height: 20)
        .padding(6)
    }
}
