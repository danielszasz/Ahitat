//
//  Ahitat + Date.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/27/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import Foundation

extension Date {
    var daySymbol: String {
        let weekDayIndex = Calendar.current.component(.weekday, from: self) - 1
        return dateFormatter.veryShortWeekdaySymbols[weekDayIndex]
    }

    var dayNumber: String {
        let formatter = dateFormatter
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }


    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "hu")
        return formatter
    }
    
    var previousMonth: String {
        let nextMonth = Calendar.current.date(byAdding: .month, value: -1, to: self) ?? Date()
        let formatter = dateFormatter
        formatter.dateFormat = "MMMM"
        return formatter.string(from: nextMonth).capitalized
    }

    var nextMonth: String {
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: self) ?? Date()
        let formatter = dateFormatter
        formatter.dateFormat = "MMMM"
        return formatter.string(from: nextMonth).capitalized
    }
    var longDate: String {
        let formatter = dateFormatter

        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: self).capitalized
    }

    func isSameDay(with date: Date) -> Bool {
        let lhsComponents = Calendar.current.dateComponents([.day, .month, .year], from: self)
        let rhsComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
        return lhsComponents.year == rhsComponents.year &&
            lhsComponents.month == rhsComponents.month &&
            lhsComponents.day == rhsComponents.day
    }
}

extension Date: Equatable {
    static func == (lhs: Date, rhs: Date) -> Bool {
        let lhsComponents = Calendar.current.dateComponents([.day, .month, .year], from: lhs)
        let rhsComponents = Calendar.current.dateComponents([.day, .month, .year], from: rhs)
        return lhsComponents.year == rhsComponents.year &&
            lhsComponents.month == rhsComponents.month &&
            lhsComponents.day == rhsComponents.day
    }
}


