//
//  SHShiftListPresenter.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

/**
Protocol that containts all related actions of shift list.
 */
protocol SHShiftListPresenterProtocol: AnyObject {
    /// Used to get a shift from a given index
    typealias ShiftItem = (_ i: Int) -> SHShiftData
    /// Number of items of the current data array
    var numberOfItems: Int { get }
    /// Containts infromation of a existing shift.
    var item: ShiftItem { get }
    /**
     Method that is in charge of the initial setup of the navigation to Add shift controller.
     */
    func goToAddShift()
    /**
     Method that is retrieves all the available shifts
     */
    func getShiftsInformation()
    /**
     Method that update the current array with a given shift data
     - Parameter shift: Data of kind `SHShiftData` that will be added.
     */
    func update(from shift: SHShiftData)
}

/**
Class that implements all related actions of shift list.
 */
class SHShiftListPresenter {
    // MARK: - Properties
    var numberOfItems: Int {
        return self.shiftList.count
    }
    var item: ShiftItem {
        return self.getShift(at:)
    }
    // MARK: - Internal Properties
    private var shiftList: [SHShiftData]
    private var interactor: SHShiftsListUseCase
    private weak var output: SHShiftsView?
    private var router: SHShiftListRouterProtocol
    
    // MARK: - Init
    init(from interactor: SHShiftsListUseCase, view: SHShiftsView, router: SHShiftListRouterProtocol) {
        self.interactor = interactor
        self.output = view
        self.router = router
        self.shiftList = []
    }
    
    // MARK: - Own methods
    private func getShift(at index: Int) -> SHShiftData { return self.shiftList[index] }
}

// MARK: - SHShiftListPresenterProtocol's implmentation
extension SHShiftListPresenter: SHShiftListPresenterProtocol {
    func goToAddShift() {
        self.router.routeToAddShift()
    }
    
    func getShiftsInformation() {
        self.interactor.getShifts { [weak self] (result: Result<[SHShiftData], SHError>) in
            guard let `self` = self else { return }
            switch result {
            case .success(let shifts):
                self.shiftList = shifts
                self.output?.didRetrieveData()
            case .failure(let error):
                self.router.routeToError(from: error)
            }
        }
    }
    
    func update(from shift: SHShiftData) {
        self.shiftList.append(shift)
        self.output?.didAddedNewShift(in: IndexPath(row: self.numberOfItems - 1, section: 0))
    }
}
