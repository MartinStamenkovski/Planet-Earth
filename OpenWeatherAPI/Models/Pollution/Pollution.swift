//
//  Pollution.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 20.12.20.
//

import Foundation

// MARK: - Pollution
public struct Pollution: Codable {
    
    public let pollutionElements: [PollutionElement]
    
    private enum CodingKeys: String, CodingKey {
        case pollutionElements = "list"
    }
}


