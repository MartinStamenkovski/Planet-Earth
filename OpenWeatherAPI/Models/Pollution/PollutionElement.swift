//
//  PollutionElement.swift
//  OpenWeatherAPI
//
//  Created by Martin Stamenkovski on 22.12.20.
//

import Foundation

// MARK: - List
public struct PollutionElement: Codable, Identifiable {
    
    public let id = UUID()
    
    public let dateTime: Int
    public let main: Main
    public let components: [String : Double]
    
    private enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case main
        case components
    }
}
