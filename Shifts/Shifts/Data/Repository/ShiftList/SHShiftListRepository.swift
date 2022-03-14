//
//  SHShiftListRepository.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/13/22.
//

import Foundation

/**
 Class that implmenets the repository protocol of shifts list
*/
class SHShiftListRepository {
    /// Property used to connect to the storage manager
    private let dataSource: SHStorageManager?
    /// Static property that contains the key of file shifts
    private static let sKey = "Shifts"
    
    init(from dataSource: SHStorageManager) {
        self.dataSource = dataSource
    }
    
    // MARK: - Own methods
}

// MARK: - SHShiftListRepositoryProtocol's implementation
extension SHShiftListRepository: SHShiftListRepositoryProtocol {
    func getShifts(completion: @escaping (Result<ShiftListModel, Error>) -> Void) {
        self.dataSource?.retrieve(from: Self.sKey, completion: completion)
    }
}
