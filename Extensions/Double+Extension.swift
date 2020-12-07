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
}

