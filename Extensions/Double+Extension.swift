//
//  Double+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 5.12.20.
//

import Foundation

extension Double {
    
    /**
     Converts the current value to Measurement with the provided UnitTemperature.
     */
    public var unitTemperature: String {
        let measurement = Measurement(value: self, unit: UnitTemperature.kelvin)
        let measurementFormatter = MeasurementFormatter.unitTemperatureFormatter
        return measurementFormatter.string(from: measurement)
    }
    
    public var unitLength: String {
        let measurement = Measurement(value: self, unit: UnitLength.meters)
        return MeasurementFormatter.unitFormatter.string(from: measurement)
    }
    
    public var unitSpeed: String {
        let measurement = Measurement(value: self, unit: UnitSpeed.metersPerSecond)
        return MeasurementFormatter.unitFormatter.string(from: measurement)
    }
    
    public var unitPressure: String {
        let measurement = Measurement(value: self, unit: UnitPressure.hectopascals)
        return MeasurementFormatter.unitFormatter.string(from: measurement)
    }
    
    public func rounded(to places: Int) -> Double {
        guard self > 0.0 else { return 0 }
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

