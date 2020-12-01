//
//  String+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 21.11.20.
//

import Foundation

public extension String {
    
    var earthQuakeDate: Date? {
        let dateFormatter = DateFormatter.earthQuakeDateFormatter
        guard let date = dateFormatter.date(from: self) else { return nil }
        return date
    }
    
    var earthQuakeTimeToCurrentLocale: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: date)
    }
    
    var firstUppercased: String {
        return prefix(1).uppercased() + self.dropFirst()
    }
}

