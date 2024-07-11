//
//  WZDoubleDateSlider.swift
//

import SwiftUI

public struct WZDoubleDateSlider: View {
    @Binding var lowDate: Date
    @Binding var highDate: Date
    
    var minDate: Date
    var maxDate: Date
    
    @State var thumbSize: CGFloat
    @State var thumbColor: Color
    @State var progressColor: Color

    @State private var lowValue: Int = 0
    @State private var highValue: Int = 0
    @State private var distance: Int = 0
    
    public init(lowDate: Binding<Date>, highDate: Binding<Date>, minDate: Date, maxDate: Date, thumbSize: CGFloat = 30, thumbColor: Color = .white, progressColor: Color = .blue) {
        _lowDate = lowDate
        _highDate = highDate
        
        self.minDate = minDate
        self.maxDate = maxDate
        self.thumbSize = thumbSize
        self.thumbColor = thumbColor
        self.progressColor = progressColor
        
        distance = maxDate.monthDistance(other: minDate)
    }
    
    
    private var lowThumbOffset: CGFloat {
        return CGFloat(lowValue) * widthPerValue
    }
    
    private var highThumbOffset: CGFloat {
        return CGFloat(highValue) * widthPerValue
    }
    
    @State private var widthPerValue: CGFloat = 0
    
    public var body: some View {
        
        let lowDragGesture = { (width: CGFloat, topLimit: Int, bottomLimit: Int) in
            let gesture = DragGesture()
                .onChanged { change  in
                    let x = change.startLocation.x + change.translation.width
                    let value = Int(x / widthPerValue)
                    if value < topLimit && value >= bottomLimit {
                        lowValue = value
                    }
                }
            return gesture
        }
        
        let highDragGesture = { (width: CGFloat, bottomLimit: Int, topLimit: Int) in
            let gesture = DragGesture()
                .onChanged { change in
                    let x = change.startLocation.x + change.translation.width
                    let value = Int(x / widthPerValue)
                    if value > bottomLimit && value <= topLimit {
                        highValue = value
                    }
                }
            return gesture
        }

        let progressDragGesture = { (width: CGFloat, bottomLimit: Int, topLimit: Int) in
            var lastLocation: CGFloat?
            let gesture = DragGesture()
                .onChanged { change in
                    guard let last = lastLocation else {
                        lastLocation = change.location.x
                        return
                    }
                                        
                    let offset = change.location.x - last
                    let diff = Int( roundf(Float(offset / widthPerValue)) )
                    if abs(diff) > 0 {
                        let newLowValue = lowValue + diff
                        let newHighValue = highValue + diff
                        
                        if newLowValue >= bottomLimit && newHighValue <= topLimit {
                            lowValue = newLowValue
                            highValue = newHighValue
                        }
                        
                        lastLocation = change.location.x
                    }
                }
                .onEnded { change in
                    lastLocation = nil
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
                    .offset(x: lowThumbOffset + thumbSize / 2)
                    .frame(width: highThumbOffset - lowThumbOffset, height: 10)
                    .gesture(progressDragGesture(geometry.size.width, 0, distance))
                
                Circle()
                    .fill(thumbColor)
                    .frame(width: thumbSize, height: thumbSize)
                    .shadow(color: .gray, radius: 1, x: 0.5, y: 0.5)
                    .offset(x: lowThumbOffset)
                    .gesture(lowDragGesture(geometry.size.width, highValue, 0))
                
                Circle()
                    .fill(thumbColor)
                    .frame(width: thumbSize, height: thumbSize)
                    .shadow(color: .gray, radius: 1, x: 0.5, y: 0.5)
                    .offset(x: highThumbOffset)
                    .gesture(highDragGesture(geometry.size.width, lowValue, distance))
            }
            .onAppear {
                distance = maxDate.monthDistance(other: minDate)
                widthPerValue = (geometry.size.width - thumbSize) / CGFloat(distance)
                
                lowValue = distance * 1 / 3
                highValue = distance * 2 / 3
            }
            .onChange(of: lowValue) { newValue in
                guard let newDate = minDate.addMonths(lowValue) else {
                    return
                }
                lowDate = newDate
            }
            .onChange(of: highValue) { newValue in
                guard let newDate = minDate.addMonths(highValue) else {
                    return
                }
                highDate = newDate
            }
            .onChange(of: lowDate) { newValue in
                lowValue = newValue.monthDistance(other: minDate)
            }
            .onChange(of: highDate) { newValue in
                highValue = newValue.monthDistance(other: minDate)
            }
            .onChange(of: minDate) { newValue in
                distance = maxDate.monthDistance(other: newValue)
            }
            .onChange(of: maxDate) { newValue in
                distance = newValue.monthDistance(other: minDate)
            }
            .onChange(of: distance) { newValue in
                widthPerValue = (geometry.size.width - thumbSize) / CGFloat(newValue)
                lowValue = lowDate.monthDistance(other: minDate)
                highValue = highDate.monthDistance(other: minDate)
            }
        }
        .frame(height: thumbSize)
    }
}
