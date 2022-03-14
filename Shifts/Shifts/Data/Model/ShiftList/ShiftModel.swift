//
//  ShiftModel.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/11/22.
//

import Foundation

struct ShiftListModel: Codable {
    /// Array of kind `ShiftModel`
    let info: [ShiftModel]
    
    private enum CodingKeys: String, CodingKey {
        case info = "shifts"
    }
}

/**
 Struct that represents all the information of a given shift
 */
struct ShiftModel: Codable {
    /// Role of the employee
    let role: String
    /// Name of the employee
    let name: String
    /// Start date of the role in format `E, yyyy-MM-d HH:mm:ss Z`
    let startDate: String
    /// End date of the role in format `E, yyyy-MM-d HH:mm:ss Z`
    let endDate: String
    /// Color of the information
    let color: String
    
    private enum CodingKeys: String, CodingKey {
        case role
        case name
        case startDate = "start_date"
        case endDate = "end_date"
        case color
    }
}
