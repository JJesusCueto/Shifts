//
//  SHAddShiftUseCase.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

/**
 Protocol that defines the use case of add shift
*/
protocol SHAddShiftUseCase: AnyObject {
    /**
     Method that retrieves all available shift information for a new entry and return an expected value depending of the result. Expected values of `SHAddShiftData` for success and `SHError` for failure.
     - Parameter completion: Closure that resturns  a result with an expected value of `SHAddShiftData` type or `SHError`.
     */
    func getShiftData(completion: @escaping(Result<SHAddShiftData, SHError>) -> Void)
}

/**
 Class that implmenets the use case of add shift
*/
class SHAddShiftInteractor {
    ///  Add Shift's repository property
    private let shiftRepository: SHAddShiftRepositoryProtocol
    /// Employees repository property
    private let employeeRepository: SHEmployeesRepositoryProtocol
    /// Dispatch group of the interactor. Used to gather and push all the information
    private let dispatchGroup: DispatchGroup
    
    init(from repository: SHAddShiftRepositoryProtocol, employeeRepository: SHEmployeesRepositoryProtocol) {
        self.shiftRepository = repository
        self.employeeRepository = employeeRepository
        self.dispatchGroup = DispatchGroup()
    }
}

// MARK: - SHAddShiftUseCase's implementation
extension SHAddShiftInteractor: SHAddShiftUseCase {
    func getShiftData(completion: @escaping (Result<SHAddShiftData, SHError>) -> Void) {
        // Create all the properties with a empty state
        var roleArray: [SHShiftRole] = []
        var colors: [SHShiftColor] = []
        var employees: [Person] = []
        self.dispatchGroup.enter()
        self.shiftRepository.getColors { [weak self] (result: Result<SHShiftColorList, Error>) in
            guard let `self` = self else { return }
            switch result {
            case .success(let colorList):
                colors = colorList.info
            case .failure(_ ): break
            }
            self.dispatchGroup.leave()
        }
        self.dispatchGroup.enter()
        self.shiftRepository.getRoles { [weak self] (result: Result<SHShiftRoleList, Error>) in
            guard let `self` = self else { return }
            switch result {
            case .success(let roles):
                roleArray = roles.info
            case .failure(_ ): break
            }
            self.dispatchGroup.leave()
        }
        self.dispatchGroup.enter()
        self.employeeRepository.getEmployees { [weak self] (result: Result<PersonList, Error>) in
            guard let `self` = self else { return }
            switch result {
            case .success(let personList):
                employees = personList.info
            case .failure(_ ): break
            }
            self.dispatchGroup.leave()
        }
        // Once all the task were performed call notify to update the changes in presentation layer
        self.dispatchGroup.notify(queue: .main) {
            guard !roleArray.isEmpty, !colors.isEmpty, !employees.isEmpty else {
                completion(.failure(SHError(from: 10, description: NSLocalizedString(SHKeys.MessageKeys.addShiftEmptyInformation, comment: SHKeys.MessageKeys.emptyText))))
                return
            }
            completion(.success(SHAddShiftData(from: employees, roles: roleArray, colors: colors)))
        }
    }
}
