//
//  SHAddShiftRepositoryProtocol.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

/**
 Protocol that defines all the available methods that will be used to add a new shift
*/
protocol SHAddShiftRepositoryProtocol: AnyObject {
    /**
     Method that retrieves all available colors and return an expected value depending of the result. Expected values of `SHShiftColorList` for success and `SHError` for failure.
     - Parameter completion: Closure that resturns  a result with an expected value of `SHShiftColorList` type or `Error`.
     */
    func getColors(completion: @escaping(Result<SHShiftColorList, Error>) -> Void)
    /**
     Method that retrieves all available roles and return an expected value depending of the result. Expected values of `SHShiftRoleList` for success and `SHError` for failure.
     - Parameter completion: Closure that resturns  a result with an expected value of `SHShiftRoleList` type or `Error`.
     */
    func getRoles(completion: @escaping(Result<SHShiftRoleList, Error>) -> Void)
}
