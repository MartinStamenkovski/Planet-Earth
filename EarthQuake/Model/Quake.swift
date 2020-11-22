//
//  EarthQuake.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 21.11.20.
//

import Foundation
import CoreLocation
import SwiftUI

struct Quake: Identifiable {
    var id = UUID()
    
    var date: Date?
    var time: String?
    
    var timeAgo: String?
    var magnitude: String?
    var depth: String?
    
    var location: QuakeLocation?
    
    var magnitudeColor: Color {
        guard let magnitude = magnitude, let doubleValue = Double(magnitude) else { return .init(.label) }
        switch doubleValue {
        case 0.0..<3.0:
            return .green
        case 3.0..<4.0:
            return .purple
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
