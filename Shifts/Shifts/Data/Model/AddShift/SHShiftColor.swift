//
//  SHShiftColor.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

struct SHShiftColorList: Codable {
    /// Array of kind `SHShiftColor`
    let info: [SHShiftColor]
    
    private enum CodingKeys: String, CodingKey {
        case info = "colors"
    }
}


struct SHShiftColor: Codable {
    /// Identifier of the color
    let id: Int
    /// Name of the color
    let name: String
}
