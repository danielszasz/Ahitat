//
//  Ahitat + Date.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/27/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import Foundation

extension Date {
    func isSameMonth(with date: Date) -> Bool {
        let lhsComponents = Calendar.current.dateComponents([.month, .year], from: self)
        let rhsComponents = Calendar.current.dateComponents([.month, .year], from: date)
        return lhsComponents.year == rhsComponents.year &&
            lhsComponents.month == rhsComponents.month
    }



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
    
    var previousMonthString: String {
        let formatter = dateFormatter
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self.previousMonth).capitalized
    }

    var previousMonth: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self) ?? Date()
    }

    var nextMonth: Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self) ?? Date()
    }

    var nextMonthString: String {
        let formatter = dateFormatter
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self.nextMonth).capitalized
    }

    var currentMonth: String {
        let formatter = dateFormatter
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self).capitalized
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

