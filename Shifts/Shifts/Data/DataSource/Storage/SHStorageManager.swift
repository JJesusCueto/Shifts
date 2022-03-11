//
//  SHStorageManager.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/11/22.
//

import Foundation

/**
 Protocol that represents the operations for any storage action
 */
protocol SHStorageManager: AnyObject {
    /**
     Method that perform a request of type GET and return an expected value depending of the especified mode and reponse status.
     - Parameter path: The resource's path of type `String`.
     - Parameter result: Closure that resturns  a result with an expected value of `Codable` type or `Error`.
     */
    func retrieve<T>(from path: String, completion: @escaping(Result<T, Error>) -> Void) where T: Codable
}
