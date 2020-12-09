//
//  Int+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import Foundation

extension Int {
    
    public func hour(timeZone: String) -> String {
        let dateFormatter = DateFormatter.hourlyDateFormatter
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return dateFormatter.string(from: date)
    }
    
    public func hourMedium(timeZone: String) -> String {
        let dateFormatter = DateFormatter.mediumTime
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return dateFormatter.string(from: date)
    }
    
    public var relativeDate: String {
        let dateFormatter = DateFormatter.relativeDateFormatter
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return dateFormatter.string(from: date)
    }
}
