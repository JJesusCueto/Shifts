//
//  SHShiftListConfigurator.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

/**
Class that performs all the setup `SHShiftsViewController`
 */
class SHShiftListConfigurator {
    // MARK: - Properties
    /// Controller property that will be injected with the new presenter
    private unowned var viewController: SHShiftsViewController
    
    init(from viewController: SHShiftsViewController) {
        self.viewController = viewController
    }
    
    /**
     Method that inject and setup all the required objects of shift presenter
     */
    func configure() -> SHShiftListPresenterProtocol {
        let dataSource = SHLocalJSONStorage()
        let repository = SHShiftListRepository(from: dataSource)
        let interactor = SHShiftListInteractor(from: repository)
        let router = SHShiftListRouter(from: self.viewController)
        return SHShiftListPresenter(from: interactor, view: self.viewController, router: router)
    }
}
