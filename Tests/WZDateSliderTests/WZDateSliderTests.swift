import Foundation
import Testing
@testable import WZDateSlider

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}


@Test func testMonthDistance() {
    let date1 = Calendar.current.date(from: DateComponents(year: 2000, month: 1))
    let date2 = Calendar.current.date(from: DateComponents(year: 2000, month: 12))
    
    #expect(date1 != nil)
    #expect(date2 != nil)
    #expect(date2!.monthDistance(other: date1!) == 11, "2000.12 - 2000.01")
    
    let date3 = Calendar.current.date(from: DateComponents(year: 2000, month: 10))
    let date4 = Calendar.current.date(from: DateComponents(year: 2001, month: 2))
    
    #expect(date3 != nil)
    #expect(date4 != nil)
    #expect(date4!.monthDistance(other: date3!) == 4, "2001.02 - 2000.10")
    
    
}
