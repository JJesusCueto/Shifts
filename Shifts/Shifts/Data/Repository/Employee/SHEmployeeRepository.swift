//
//  SHEmployeeRepository.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

/**
 Class that implments all the available methods that will be used for every employee
*/
class SHEmployeeRepository {
    /// Data Source object used for access to the required data
    private let dataSource: SHLocalJSONStorage
    /// Static property that contains the key of file People file
    private static let sKey = "People"
    
    init(from dataSource: SHLocalJSONStorage) {
        self.dataSource = dataSource
    }
}

// MARK: - SHEmployeeRepositoryPorotocol's implementation
extension SHEmployeeRepository: SHEmployeesRepositoryProtocol {
    func getEmployees(completion: @escaping (Result<PersonList, Error>) -> Void) {
        self.dataSource.retrieve(from: Self.sKey, completion: completion)
    }
}
