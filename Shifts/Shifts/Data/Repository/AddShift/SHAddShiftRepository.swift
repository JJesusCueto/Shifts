//
//  SHAddShiftRepository.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

/**
 Class that implments all the available methods that will be used for every employee
*/
class SHAddShiftRepository {
    /// Data Source object used for access to the required data
    private let dataSource: SHLocalJSONStorage
    /// Static property that contains the key of file Roles file
    private static let rKey = "Roles"
    /// Static property that contains the key of file Colors file
    private static let cKey = "Colors"
    
    init(from dataSource: SHLocalJSONStorage) {
        self.dataSource = dataSource
    }
}

// MARK: - SHAddShiftRepositoryProtocol's implementation
extension SHAddShiftRepository: SHAddShiftRepositoryProtocol {
    func getColors(completion: @escaping (Result<SHShiftColorList, Error>) -> Void) {
        self.dataSource.retrieve(from: Self.cKey, completion: completion)
    }
    
    func getRoles(completion: @escaping (Result<SHShiftRoleList, Error>) -> Void) {
        self.dataSource.retrieve(from: Self.rKey, completion: completion)
    }
}
