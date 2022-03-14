//
//  SHAddShiftPresenter.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import Foundation

/**
Protocol that containts all related actions of shift list.
 */
protocol SHAddShiftPresenterProtocol: AnyObject {
    /// Used to get a shift from a given index
    typealias Item = (_ i: Int) -> String
    /// Number of items of the current data array
    var numberOfItems: Int { get }
    /// Containts infromation of a existing shift.
    var item: Item { get }
    /// Identifier of the current textfield
    var tag: Int { get set }
    /// Value that defines wheter the save button is able or not
    var isReady: Bool { get }
    /**
     Method that is in charge of add the new shift.
     */
    func addShift()
    /**
     Method that update the current array with a given shift data
     - Parameter value: Data of kind `String` that will be added to the shift.
     */
    func updateEntry(from value: String)
    /**
     Method that retrieve all the information of the shift
     */
    func loadData()
}

/**
Class that implements all related actions of shift list.
 */
class SHAddShiftPresenter {
    // MARK: - Properties
    var tag: Int {
        get { return self.currentTag }
        set { self.currentTag = newValue }
    }
    var item: Item { return self.getItem(at:) }
    var isReady: Bool {
        return !self.employeeName.isEmpty && !self.roleName.isEmpty && !self.colorName.isEmpty && !self.startDate.isEmpty && !self.endDate.isEmpty
    }
    var numberOfItems: Int {
        switch currentTag {
        case 2: return self.shiftInfo?.employees.count ?? 0
        case 3: return self.shiftInfo?.roles.count ?? 0
        case 4: return self.shiftInfo?.colors.count ?? 0
        default: return 0
        }
    }
    // MARK: - Internal Properties
    private var shiftInfo: SHAddShiftData?
    private var interactor: SHAddShiftUseCase
    private weak var output: SHAddShiftView?
    private var router: SHAddShiftRouterProtocol
    private var currentTag: Int
    /// Employee name
    private var employeeName: String
    /// Role name
    private var roleName: String
    /// Color name
    private var colorName: String
    /// Start date of the shift
    private var startDate: String
    /// End date of the shift 
    private var endDate: String
    
    // MARK: - Init
    init(from interactor: SHAddShiftUseCase, view: SHAddShiftView, router: SHAddShiftRouterProtocol) {
        self.interactor = interactor
        self.output = view
        self.router = router
        self.currentTag = 0
        self.employeeName = SHKeys.MessageKeys.emptyText
        self.roleName = SHKeys.MessageKeys.emptyText
        self.colorName = SHKeys.MessageKeys.emptyText
        self.startDate = SHKeys.MessageKeys.emptyText
        self.endDate = SHKeys.MessageKeys.emptyText
    }
    
    // MARK: - Own methods
    private func getItem(at index: Int) -> String {
        switch currentTag {
        case 2: return self.shiftInfo?.employees[index].name ?? SHKeys.MessageKeys.emptyText
        case 3: return self.shiftInfo?.roles[index].name ?? SHKeys.MessageKeys.emptyText
        case 4: return self.shiftInfo?.colors[index].name ?? SHKeys.MessageKeys.emptyText
        default: return SHKeys.MessageKeys.emptyText
        }
    }
}

// MARK: - SHShiftListPresenterProtocol's implmentation
extension SHAddShiftPresenter: SHAddShiftPresenterProtocol {
    func updateEntry(from value: String) {
        var displayText = SHKeys.MessageKeys.emptyText
        switch self.currentTag {
        case 0: // Start date
            self.startDate = value
            displayText = value
        case 1: // End date
            self.endDate = value
            displayText = value
        case 2: // Employee Name
            self.employeeName = self.shiftInfo?.employees[Int(value) ?? 0].name ?? SHKeys.MessageKeys.emptyText
            displayText = self.employeeName
        case 3: // Role Name
            self.roleName = self.shiftInfo?.roles[Int(value) ?? 0].name ?? SHKeys.MessageKeys.emptyText
            displayText = self.roleName
        case 4: // Color
            self.colorName = self.shiftInfo?.colors[Int(value) ?? 0].name ?? SHKeys.MessageKeys.emptyText
            displayText = self.colorName
        default : break
        }
        self.output?.updateTextField(from: self.currentTag, info: displayText)
    }
    
    func addShift() {
        let newShift = SHShiftData(from: ShiftModel(role: self.roleName, name: self.employeeName, startDate: self.startDate, endDate: self.endDate, color: self.colorName))
        self.router.routeToShiftList(newValue: newShift)
    }
    
    func loadData() {
        self.interactor.getShiftData { [weak self] (result: Result<SHAddShiftData, SHError>) in
            switch result {
            case .success(let data):
                self?.shiftInfo = data
                self?.output?.didRetrieveData()
            case .failure(let error):
                self?.router.routeToError(from: error)
            }
        }
    }
}
