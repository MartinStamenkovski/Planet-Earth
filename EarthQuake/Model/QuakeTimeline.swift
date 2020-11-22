//
//  EarthQuakeTimeline.swift
//  EarthQuake
//
//  Created by Martin Stamenkovski on 21.11.20.
//

import Foundation

struct QuakeTimeline: Identifiable {
    var id = UUID()
    
    let time: String
    
    private(set) var quakes: [Quake] = []
    
    mutating func append(earthQuake: Quake) {
        self.quakes.append(earthQuake)
    }
}
