//
//  Ahitat + Date.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/27/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import Foundation

extension Date {
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
}


