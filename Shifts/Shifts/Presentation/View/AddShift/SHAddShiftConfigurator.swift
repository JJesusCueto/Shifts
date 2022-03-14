//
//  SHAddShiftConfigurator.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

/**
Class that performs all the setup `SHAddShiftViewController`
 */
class SHAddShiftConfigurator {
    // MARK: - Properties
    /// Controller property that will be injected with the new presenter
    private unowned var viewController: SHAddShiftViewController
    /// Delegate property of kind `SHAddShiftViewDelegate`
    private weak var delegate: SHAddShiftViewDelegate?
    
    init(from viewController: SHAddShiftViewController) {
        self.viewController = viewController
    }
    
    func set(delegate: SHAddShiftViewDelegate) {
        self.delegate = delegate
    }
    
    /**
     Method that inject and setup all the required objects of shift presenter
     */
    func configure() -> SHAddShiftPresenterProtocol {
        let dataSource = SHLocalJSONStorage()
        let shiftRepository = SHAddShiftRepository(from: dataSource)
        let employeeRepository = SHEmployeeRepository(from: dataSource)
        let interactor = SHAddShiftInteractor(from: shiftRepository, employeeRepository: employeeRepository)
        let router = SHAddShiftRouter(from: self.viewController)
        self.viewController.delegate = self.delegate
        return SHAddShiftPresenter(from: interactor, view: self.viewController, router: router)
    }
}
