//
//  SHShiftRole.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

struct SHShiftRoleList: Codable {
    /// Array of kind `SHShiftRole`
    let info: [SHShiftRole]
    
    private enum CodingKeys: String, CodingKey {
        case info = "roles"
    }
}


struct SHShiftRole: Codable {
    /// Identifier of the role
    let id: Int
    /// Name of the role
    let name: String
}
