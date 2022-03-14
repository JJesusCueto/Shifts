//
//  ShiftData.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/13/22.
//

import Foundation

/**
 Struct that represents a shift model that will be displayed by every cell
*/
struct SHShiftData: Codable {
    /// Color of the shift
    let color: String
    /// Schedule of the shift represented by a range
    let schedule: String
    /// `String` that containts relevant information of the shift (Name, role, date)
    let information: String
    
    init(from shiftModel: ShiftModel) {
        self.color = shiftModel.color
        self.schedule = Date.getHours(from: shiftModel.startDate, finalDate: shiftModel.endDate)
        self.information = shiftModel.name + " (\(shiftModel.role)) " + Date.getFormattedDate(format: "E, MMM d", from: shiftModel.startDate)
    }
}
