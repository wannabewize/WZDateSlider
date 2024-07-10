//
//  Library.swift
//

import Foundation

extension Date {
    func monthDistance(other: Date) -> Int {
        let diffComps = Calendar.current.dateComponents([.year, .month], from: other, to: self)
        let distance = (diffComps.year ?? 0) * 12 + (diffComps.month ?? 0)
        return distance
    }
        
    func addMonths(_ amount: Int) -> Date? {
        let component = DateComponents(month: amount)
        return Calendar.current.date(byAdding: component, to: self)
    }
}

