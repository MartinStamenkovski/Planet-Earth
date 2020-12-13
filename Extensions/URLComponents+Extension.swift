//
//  URLComponents+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 12.12.20.
//

import Foundation


extension URLComponents {
    
    public mutating func appendQueryItems(_ items: [String: String?]) {
        self.queryItems = items.map { URLQueryItem(name: $0, value: $1)}
    }
}
