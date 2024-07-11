//
//  WZSingleDateSlider.swift
//

import SwiftUI

public struct WZSingleDateSlider: View {
    @Binding var date: Date
    var minDate: Date
    var maxDate: Date

    @State var thumbSize: CGFloat
    @State var thumbColor: Color
    @State var progressColor: Color
                
    @State private var value: Int = 0
    @State private var distance: Int
    
    public init(date: Binding<Date>, minDate: Date, maxDate: Date, thumbSize: CGFloat = 30, thumbColor: Color = .white, progressColor: Color = .blue) {
        _date = date // ??? why not $date = data
        self.minDate = minDate
        self.maxDate = maxDate
        self.thumbSize = thumbSize
        self.thumbColor = thumbColor
        self.progressColor = progressColor
        
        distance = maxDate.monthDistance(other: minDate)
        value = Int(distance / 2)
    }
    
    private var thumbOffset: CGFloat {
        return CGFloat(value) * widthPerValue
    }
    @State private var widthPerValue: CGFloat = 0
    
    public var body: some View {
        let dragGesture = { (width: CGFloat, lowLimit: Int, highLimit: Int) in
            let gesture = DragGesture()
                .onChanged { change in
                    let x = change.startLocation.x + change.translation.width
                    let newValue = Int(x / widthPerValue)
                    
                    if newValue >= lowLimit && newValue <= highLimit {
                        value = newValue
                    }
                }
            return gesture
        }
        
        GeometryReader { geometry in
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Rectangle()
                    .fill(Color(.lightGray))
                    .frame(height: 4)
                
                Rectangle()
                    .fill(progressColor)
                    .frame(width: thumbOffset, height: 5)
                
                Circle()
                    .fill(thumbColor)
                    .frame(width: thumbSize, height: thumbSize)
                    .shadow(color: .gray, radius: 1, x: 0.5, y: 0.5)
                    .offset(x: thumbOffset)
                    .gesture(dragGesture(geometry.size.width, 0, distance))
            }
            .onAppear {
                widthPerValue = (geometry.size.width - thumbSize) / CGFloat(distance)
            }
            .onChange(of: value) { newValue in
                guard let newDate = minDate.addMonths(value) else {
                    return
                }
                date = newDate
            }
            .onChange(of: date) { newValue in
                value = newValue.monthDistance(other: minDate)
            }
            .onChange(of: minDate) { newValue in
                distance = maxDate.monthDistance(other: newValue)
            }
            .onChange(of: maxDate) { newValue in
                distance = newValue.monthDistance(other: minDate)
            }
            .onChange(of: distance) { newValue in
                widthPerValue = (geometry.size.width - thumbSize) / CGFloat(newValue)
                value = date.monthDistance(other: minDate)
            }
        }
        .frame(height: thumbSize)
    }
}
