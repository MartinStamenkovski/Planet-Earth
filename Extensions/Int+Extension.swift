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
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow"
        }
        let dateFormatter = DateFormatter.shortDayDateFormatter
        return dateFormatter.string(from: date)
    }
}
