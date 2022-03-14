//
//  SHError.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/11/22.
//

import Foundation

/**
 Struct that represent an given error
 */
struct SHError: Error, Codable {
    
    /// Identifier of the error
    let code: Int
    /// Description of de error
    let description: String
    
    init(from code: Int, description: String) {
        self.code = code
        self.description = description
    }
}
