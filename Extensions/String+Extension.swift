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
        let dateFormatter = DateFormatter.earthQuakeDateFormatter
        dateFormatter.dateFormat = "HH:mm:ss"
        
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: date)
    }
}

