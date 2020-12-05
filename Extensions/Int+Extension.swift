//
//  Int+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import Foundation

extension Int {
    
    public var hour: String {
        let dateFormatter = DateFormatter.hourlyDateFormatter
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return dateFormatter.string(from: date)
    }
    
}
