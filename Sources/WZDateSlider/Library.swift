//
//  Library.swift
//

import Foundation

func calculateValue(x: CGFloat, width: CGFloat, minValue: Float, maxValue: Float) -> Float {
    let widthPerValue = Float(width) / (maxValue - minValue)
    return roundf( Float(x) / widthPerValue ) + minValue
}

func calculateOffset(value: Float, maxValue: Float, width: CGFloat) -> CGFloat {
    let offset = roundf( (value / maxValue) * Float(width) )
    return CGFloat(offset)
}




extension DateComponents {
    static func <=(lhs: Self, rhs: Self) -> Bool {
        guard let yearL = lhs.year, let yearR = rhs.year,
              let monthL = lhs.month, let monthR = rhs.month else {
                  return false
              }
        
        if yearL < yearR || (yearL == yearR && monthL <= monthR) {
            return true
        }
        else {
            return false
        }
    }
}


extension String {
}

extension Date {
    
    func monthDistance(other: Date) -> Int {
        let diffComps = Calendar.current.dateComponents([.year, .month], from: other, to: self)
        let distance = (diffComps.year ?? 0) * 12 + (diffComps.month ?? 0)
        print("month diff - year:", diffComps.year, "month:", diffComps.month, "distance :", distance)
        return distance
    }
    
    func dayDistance(other: Date) -> Int {
        let diffComps = Calendar.current.dateComponents([.year, .month, .day], from: self, to: other)
        return diffComps.day ?? 0
    }
    
    func addMonths(_ amount: Int) -> Date? {
        let component = DateComponents(month: amount)
        return Calendar.current.date(byAdding: component, to: self)
    }
}

