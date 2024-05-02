//
//  UnitConversionHandler.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 02/04/24.
//

import Foundation

class UnitConversionHandler{
    
    static let shared = UnitConversionHandler()
    private init(){}
    
    func convertCmToInches<T: BinaryFloatingPoint>(_ cm: T) -> T {
        let inchesPerCentimeter: T = 0.393701 // 1 centimeter is approximately 0.393701 inches
        return (cm * inchesPerCentimeter).rounded()
    }
    
    func convertInchesToCm<T: BinaryFloatingPoint>(_ inches: T) -> T {
        let centimeterPerInche: T = 2.54 // 1 inch is approximately 2.54 cm
        return (inches * centimeterPerInche).rounded()
    }
    
}
