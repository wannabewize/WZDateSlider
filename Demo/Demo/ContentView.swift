//
//  ContentView.swift
//  WZDateSlider Demo App
//

import SwiftUI
import WZDateSlider

let yyyymmFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM"
    return formatter
}()

let yyyymmddFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

extension Date {
    var toYYYYMM: String {
        return yyyymmFormatter.string(from: self)
    }
    
    static func from(year: Int, month: Int = 0, day: Int = 1) -> Date? {
        return Calendar.current.date(from: DateComponents(year: year, month: month, day: day))
    }

    static func fromYYYYMM(_ str: String) -> Date {
        return yyyymmFormatter.date(from: str)!
    }
    
    static func fromYYYYMMDD(str: String) -> Date? {
        return yyyymmddFormatter.date(from: str)
    }
}

struct ContentView: View {
    @State var date = Date()
    
    @State var minDate = Calendar.current.date(from: DateComponents(year: 2000, month: 1))!
    @State var maxDate = Calendar.current.date(from: DateComponents(year: 2000, month: 12))!
    
    @State var lowDate = Date()
    @State var highDate = Date()
    
    @State var sliderValue: Float = 5
    
    var body: some View {

        VStack {
            HStack {
                Button("<") {
                    minDate = Calendar.current.date(byAdding: .month, value: -1, to: minDate)!
                }
                
                Spacer()
                
                Text("Change Month (Min, Max)")
                
                Spacer()

                Button(">") {
                    maxDate = Calendar.current.date(byAdding: .month, value: 1, to: maxDate)!
                }

            }
            .padding(.horizontal, 20)
            
            Divider()
                .padding(.vertical, 20)
            
            WZSingleDateSlider(date: $date, minDate: minDate, maxDate: maxDate)
            WZSingleDateSlider(date: $date, minDate: minDate, maxDate: maxDate, thumbSize: 40, thumbColor: .yellow, progressColor: .brown)
            HStack {
                Text("\(minDate.toYYYYMM)")
                Spacer()
                Text("\(date.toYYYYMM)")
                Spacer()
                Text("\(maxDate.toYYYYMM)")
            }
            
            WZDoubleDateSlider(lowDate: $lowDate, highDate: $highDate, minDate: minDate, maxDate: maxDate)
            WZDoubleDateSlider(lowDate: $lowDate, highDate: $highDate, minDate: minDate, maxDate: maxDate, thumbSize: 50, thumbColor: .green, progressColor: .black)
            HStack {
                Text("\(minDate.toYYYYMM)")
                Spacer()
                Text("\(lowDate.toYYYYMM) - \(highDate.toYYYYMM)")
                Spacer()
                Text("\(maxDate.toYYYYMM)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
