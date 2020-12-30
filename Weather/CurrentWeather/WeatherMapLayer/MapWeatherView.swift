//
//  MapWeatherView.swift
//  Weather
//
//  Created by Martin Stamenkovski on 13.12.20.
//

import SwiftUI
import MapKit
import OpenWeatherAPI
import PEMapView
import Extensions

struct MapWeatherView: View {
    
    @Binding var region: MKCoordinateRegion?
    @State private var tiles: [MKTileOverlay] = []
    
    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(OpenWeatherLayer.allCases, id: \.self) { layer in
                        configureLayerRow(with: layer)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
            }
            PEMapView(
                region: $region,
                tiles: $tiles,
                scrollEnabled: false
            )
            .frame(height: 200)
            .cornerRadius(12)
            .padding(.horizontal)
            
        }
    }
    
    private func isLayerSelected(_ layer: OpenWeatherLayer) -> Bool {
        return (self.tiles.first as? OpenWeatherTile)?.layer == layer
    }
    
    private func configureLayerRow(with layer: OpenWeatherLayer) -> AnyView {
        return MapLayerTypeRow(layerType: layer)
            .background(isLayerSelected(layer) ? Color(.systemBlue) : Color(.secondarySystemBackground))
            .addBorder(Color.gray, cornerRadius: 12)
            .contentShape(Rectangle())
            .onTapGesture {
                guard !isLayerSelected(layer) else { return }
                self.tiles.removeAll()
                withAnimation(Animation.easeInOut.delay(0.2)) {
                    self.tiles = [OpenWeatherTile(layer: layer)]
                }
            }
            .toAnyView()
    }
}
