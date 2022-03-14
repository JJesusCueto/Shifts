//
//  SHAddShiftRouter.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import UIKit

/**
Protocol that containts all the navigation related actions of shift list.
 */
protocol SHAddShiftRouterProtocol: AnyObject {
    /// ViewController used for all the required actions
    var viewController: UIViewController { get }
    /**
     Method that is in charge of the navifation to `SHShiftListViewController`.
     - Parameter newValue: Data of kind `SHShiftData` that containts the new shift.
     */
    func routeToShiftList(newValue: SHShiftData)
    /**
     Method that is in charge of show a given error of kindf `SHError`.
     - Parameter error: Data of kind `SHError` that containts the description.
     */
    func routeToError(from error: SHError)
}

/**
Class that performs all the navigation related actions. Depends on `SHShiftsViewController`
 */
class SHAddShiftRouter {
    // MARK: - Properties
    /// ViewController used for actions. It is of kind `SHShiftListViewController
    private unowned var routerController: SHAddShiftViewController
    var viewController: UIViewController {
        return self.routerController
    }
    
    // MARK: - Init
    init(from viewController: SHAddShiftViewController) {
        self.routerController = viewController
    }
}

// MARK: - SHShiftListRouterProtocol's implementation
extension SHAddShiftRouter: SHAddShiftRouterProtocol {
    func routeToShiftList(newValue: SHShiftData) {
        self.viewController.dismiss(animated: true) { [weak self] in
            self?.routerController.delegate?.didAdd(shift: newValue)
        }
    }
    
    func routeToError(from error: SHError) {
        let alertController = UIAlertController(title: nil, message: error.description, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
            self?.viewController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(action)
        self.viewController.present(alertController, animated: true, completion: nil)
    }
}
