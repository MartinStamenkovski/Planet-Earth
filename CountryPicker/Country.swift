//
//  Country.swift
//  CountryPicker
//
//  Created by Martin Stamenkovski on 29.11.20.
//

import Foundation

public struct Country: Codable, Identifiable, Equatable {
    public let id = UUID()
    
    public let name: String
    public let code: String?
    public let flagURL: String?
    
    public init(name: String) {
        self.name = name
        self.flagURL = nil
        self.code = nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case flagURL = "imageURL"
        case name
        case code
    }
    
    public var quakeQueryName: String {
        if self.name.lowercased() == "united kingdom" {
            return "uk"
        }
        return self.name.replacingOccurrences(of: " ", with: "-").lowercased()
    }
    
    public static func ==(lhs: Country, rhs: Country) -> Bool {
        return lhs.name.lowercased() == rhs.name.lowercased()
    }
    
    var isToday: Bool {
        return self.name.lowercased() == "today"
    }
}
