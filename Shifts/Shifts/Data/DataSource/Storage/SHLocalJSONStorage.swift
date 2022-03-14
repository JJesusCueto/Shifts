//
//  SHLocalStorage.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/11/22.
//

import Foundation

class SHLocalJSONStorage: SHStorageManager {
    
    // MARK: - Init
    init() {}
    
    // MARK: - SHStorageManager
    func retrieve<T>(from path: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        if let path = Bundle.main.path(forResource: path, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
              } catch {
                  completion(.failure(SHError(from: 0, description: error.localizedDescription)))
              }
        } else {
            completion(.failure(SHError(from: 1, description: "Could not get resource")))
        }
    }
}
