//
//  EarthQuake.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 21.11.20.
//

import Foundation
import CoreLocation

struct Quake {
    
    var date: String?
    var timeAgo: String?
    var magnitude: String?
    var depth: String?
    
}

struct QuakeLocation {
    
    let coordinates: CLLocationCoordinate2D?
    let flag: String?
    let name: String?
}
