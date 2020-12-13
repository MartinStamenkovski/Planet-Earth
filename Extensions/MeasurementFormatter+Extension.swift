//
//  MeasurementFormatter+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import Foundation


extension MeasurementFormatter {
    
    static let unitFormatter: MeasurementFormatter = {
       let formatter = MeasurementFormatter()
        formatter.locale = .current
        formatter.numberFormatter.maximumFractionDigits = 1
        formatter.unitStyle = .short
        
        return formatter
    }()
    
    static let unitTemperatureFormatter: MeasurementFormatter = {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.locale = .current
        return measurementFormatter
    }()
    
}
