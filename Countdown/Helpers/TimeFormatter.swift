//
//  TimeFormatter.swift
//  Countdown
//
//  Created by MAA on 31.08.2022.
//

import Foundation

func calcTimeSince(date: Date) -> String {    
    let start = Date.now
    let end = date
    
    let calendar = Calendar.current
    
    let date1 = calendar.startOfDay(for: start)
    let date2 = calendar.startOfDay(for: end)
    
    let components = calendar.dateComponents([.day], from: date1, to: date2)
    
    let day = components.day
    let dayStr = "\(day ?? 0)"
    
    return dayStr
}

func dateRangeFunc() -> ClosedRange<Date> {
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let minDate = calendar.date(byAdding: .day, value: 0, to: .now)
        let maxDate = calendar.date(byAdding: .year, value: 10, to: .now)
        
        return minDate!...maxDate!
    }()
    
    return dateRange
}


