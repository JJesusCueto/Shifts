//
//  SHShiftsListUseCase.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/13/22.
//

import Foundation

/**
 Protocol that defines the use case of shifts list
*/
protocol SHShiftsListUseCase: AnyObject {
    /**
     Method that retrieves all available shifts and return an expected value depending of the result. Expected values of `SHShifData` for success and `SHError` for failure.
     - Parameter completion: Closure that resturns  a result with an expected value of `SHShiftData` type or `SHError`.
     */
    func getShifts(completion: @escaping(Result<[SHShiftData], SHError>) -> Void)
}

/**
 Class that implmenets the use case of shifts list
*/
class SHShiftListInteractor {
    ///  Shift repository property
    private let repository: SHShiftListRepositoryProtocol
    
    init(from repository: SHShiftListRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - SHShiftsListUseCase's implementation
extension SHShiftListInteractor: SHShiftsListUseCase {
    func getShifts(completion: @escaping (Result<[SHShiftData], SHError>) -> Void) {
        self.repository.getShifts { (result: Result<ShiftListModel, Error>) in
            switch result {
            case .success(let shifts):
                let shiftsData = shifts.info.map { SHShiftData(from: $0) }
                completion(.success(shiftsData))
            case .failure(let error):
                completion(.failure(SHError(from: 1, description: error.localizedDescription)))
            }
        }
    }
}
