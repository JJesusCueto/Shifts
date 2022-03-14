//
//  Util+Extensions.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

// MARK: - Date
extension Date {
    static func getFormattedDate(format: String, from value: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        let date = dateFormatterGet.date(from: value)
        return dateformat.string(from: date ?? Date())
     }
    
    static func getHours(from initialDate: String, finalDate: String) -> String {
        return self.getFormattedDate(format: "h", from: initialDate) + " - " + self.getFormattedDate(format: "h a", from: finalDate)
    }
}
