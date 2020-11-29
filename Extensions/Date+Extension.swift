//
//  Date+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 22.11.20.
//

import Foundation

public extension Date {
    
    func shortTimeOnly() -> String? {
        let dateFormatter = DateFormatter.dateFormatterUTC
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
    func timeAgo() -> String {
        let formatter = DateFormatter.timeAgoFormatter
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    var earthQuakeDateToCurrentLocale: String? {
        let dateFormatter = DateFormatter.earthQuakeDateFormatter
            
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: self)
    }
}
