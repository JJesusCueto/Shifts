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
    func getShifts(completion: @escaping(Result<SHShiftData, SHError>) -> Void)
}

/**
 Class that implmenets the use case of shifts list
*/
class SHShiftListInteractor {
}

// MARK: - SHShiftsListUseCase's implementation
extension SHShiftListInteractor: SHShiftsListUseCase {
    func getShifts(completion: @escaping (Result<SHShiftData, SHError>) -> Void) {
        
    }
}
