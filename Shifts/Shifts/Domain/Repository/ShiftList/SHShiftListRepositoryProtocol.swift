//
//  SHShiftListRepositoryProtocol.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/13/22.
//

import Foundation

/**
 Protocol that defines all the available methods that will be used for every shift related implementation
*/
protocol SHShiftListRepositoryProtocol: AnyObject {
    /**
     Method that retrieves all available shifts and return an expected value depending of the result. Expected values of `SHShifData` for success and `SHError` for failure.
     - Parameter completion: Closure that resturns  a result with an expected value of `ShiftListModel` type or `Error`.
     */
    func getShifts(completion: @escaping(Result<ShiftListModel, Error>) -> Void)
}
