//
//  Rain.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 22.12.20.
//

import Foundation


// MARK: - Rain
public struct Rain: Codable {
    public let the1H: Double
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}
