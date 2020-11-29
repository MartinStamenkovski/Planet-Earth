//
//  EarthQuake.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 21.11.20.
//

import Foundation
import CoreLocation
import SwiftUI
import PEMapView

struct Quake: Identifiable {
    var id = UUID()
    
    var date: Date?
    var time: String?
    
    var timeAgo: String?
    var magnitude: String?
    var depth: String?
    
    var location: QuakeLocation?
    
    var magnitudeColor: UIColor {
        guard let magnitude = magnitude, let doubleValue = Double(magnitude) else { return .label }
        switch doubleValue {
        case 0.0..<3.0:
            return .systemGreen
        case 3.0..<4.0:
            return .systemPurple
        case 4.0..<5.0:
            return .orange
        default:
            return .red
        }
    }
   
}

struct QuakeLocation {
    
    var coordinates: CLLocationCoordinate2D?
    var flag: String?
    var name: String?
    var detailInfo: String?
    var country: String?
    
    var flagURL: URL? {
        if let flag = self.flag {
            return URL(string: "https://www.volcanodiscovery.com/\(flag)")
        }
        return nil
    }
}


extension Quake {
    
    func toAnnotation() -> Artwork? {
        guard let location = self.location, let coordinates = location.coordinates else { return nil }
        let artwork = Artwork(coordinate: coordinates, title: location.country, subtitle: location.name)
        artwork.glyphText = self.magnitude
        artwork.color = self.magnitudeColor
        artwork.userInfo = self
        artwork.id = self.id
        return artwork
    }
}
