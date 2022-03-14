//
//  SHEmployeesRepositoryProtocol.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

/**
 Protocol that defines all the available methods that will be used for every employee
*/
protocol SHEmployeesRepositoryProtocol: AnyObject {
    /**
     Method that retrieves all available employees and return an expected value depending of the result. Expected values of `PersonList` for success and `SHError` for failure.
     - Parameter completion: Closure that resturns  a result with an expected value of `PersonList` type or `Error`.
     */
    func getEmployees(completion: @escaping(Result<PersonList, Error>) -> Void)
}
