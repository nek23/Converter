//
//  DateModel.swift
//  Converter
//
//  Created by Alex on 14.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

class DateModel {
    var dates = Date().getDates(forLastNDays: 15)
}



extension Date {
    
    func subtract (days: Int) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: .day, value: -days, to: self)!
        return targetDay
    }
    
    func getDates(forLastNDays nDays: Int) -> [String] {
        let cal = NSCalendar.current
        var date = cal.startOfDay(for: self.subtract(days: -1))
        var arrDates = [String]()
        
        for _ in 0 ... nDays {
            date = cal.date(byAdding: Calendar.Component.day, value: -1, to: date)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: date)
            arrDates.append(dateString)
        }
        return arrDates
    }
    
    func addDates() {
        self.subtract(days: 16)
        self.getDates(forLastNDays: 15)
    }
}
