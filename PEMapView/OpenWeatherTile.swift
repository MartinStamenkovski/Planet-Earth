//
//  OpenWeatherTile.swift
//  PEMapView
//
//  Created by Martin Stamenkovski on 13.12.20.
//

import Foundation
import MapKit
import OpenWeatherAPI

public final class OpenWeatherTile: MKTileOverlay {
    
    public private(set) var layer: OpenWeatherLayer = .temperature
    
    public convenience init(layer: OpenWeatherLayer) {
        self.init()
        self.layer = layer
    }
    
    override public func url(forTilePath path: MKTileOverlayPath) -> URL {
        return .openWeatherLayer(for: layer, z: path.z, x: path.x, y: path.y)
    }
}
