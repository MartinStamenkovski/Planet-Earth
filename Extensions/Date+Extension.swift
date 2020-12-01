//
//  Date+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 22.11.20.
//

import Foundation

public extension Date {
    
    func shortTimeOnly() -> String? {
        let dateFormatter = DateFormatter.shortTime
        return dateFormatter.string(from: self)
    }
    
    func timeAgo() -> String {
        let formatter = DateFormatter.timeAgoFormatter
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    var earthQuakeDateToCurrentLocale: String? {
        let dateFormatter = DateFormatter.shortEarthQuakeDate
        return dateFormatter.string(from: self)
    }
}
