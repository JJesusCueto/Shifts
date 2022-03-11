//
//  Person.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/11/22.
//

import Foundation

struct PersonList: Codable {
    /// Array of kind `Person`
    let info: [Person]
    
    private enum CodingKeys: String, CodingKey {
        case info = "person"
    }
}


struct Person: Codable {
    /// Identifier of the person
    let id: Int
    /// Name of the person
    let name: String
}
