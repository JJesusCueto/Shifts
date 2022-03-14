//
//  SHShiftListRouter.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import UIKit

/**
Protocol that containts all the navigation related actions of shift list.
 */
protocol SHShiftListRouterProtocol: AnyObject {
    /// ViewController used for all the required actions
    var viewController: UIViewController { get }
    /**
     Method that is in charge of the navifation and setup of `SHAddShiftViewController`.
     */
    func routeToAddShift()
    /**
     Method that is in charge of show a given error of kindf `SHError`.
     - Parameter error: Data of kind `SHError` that containts the description.
     */
    func routeToError(from error: SHError)
}

/**
Class that performs all the navigation related actions. Depends on `SHShiftsViewController`
 */
class SHShiftListRouter {
    // MARK: - Properties
    /// ViewController used for actions. It is of kind `SHShiftListViewController
    private unowned var routerController: UIViewController
    var viewController: UIViewController {
        return self.routerController
    }
    
    // MARK: - Init
    init(from viewController: UIViewController) {
        self.routerController = viewController
    }
}

// MARK: - SHShiftListRouterProtocol's implementation
extension SHShiftListRouter: SHShiftListRouterProtocol {
    func routeToAddShift() {
    }
    
    func routeToError(from error: SHError) {
        let alertController = UIAlertController(title: nil, message: error.description, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        self.viewController.present(alertController, animated: true, completion: nil)
    }
}
