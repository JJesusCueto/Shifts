//
//  SHAddShiftData.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

/**
 Struct that represents a shift model that will be added by the user
*/
struct SHAddShiftData: Codable {
    /// Array of Colors of the shift
    let colors: [SHShiftColor]
    /// Array of Roles of the shift
    let roles: [SHShiftRole]
    /// Array of employees of the company
    let employees: [Person]
    
    init(from employees: [Person], roles: [SHShiftRole], colors: [SHShiftColor]) {
        self.employees = employees
        self.roles = roles
        self.colors = colors
    }
}
