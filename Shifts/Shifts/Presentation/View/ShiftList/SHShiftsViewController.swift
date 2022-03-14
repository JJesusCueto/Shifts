//
//  SHShiftsViewController.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/11/22.
//

import UIKit

/**
Protocol that is used to be the comunication between controller and presenter
 */
protocol SHShiftsView: AnyObject {
    /**
    Method that is triggered when the retrieval of the information is completed.
     */
    func didRetrieveData()
    /**
    Method that is update the table view with new information,
     - Parameter indexPath:Index of the new information
     */
    func didAddedNewShift(in indexPath: IndexPath)
}

class SHShiftsViewController: UIViewController {
    // MARK: - Properties
    private lazy var configurator: SHShiftListConfigurator = { return SHShiftListConfigurator(from: self) }()
    private lazy var presenter: SHShiftListPresenterProtocol = { return self.configurator.configure() }()
    // MARK: - View Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8.0, bottom: 0.0, right: 0.0)
        tableView.register(SHShiftTableViewCell.self, forCellReuseIdentifier: SHKeys.shiftCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.initViews()
    }
    
    // MARK: - Setup
    private func initViews() {
        self.view.backgroundColor = .white
        self.title = NSLocalizedString(SHKeys.MessageKeys.shiftListControllerTitle, comment: SHKeys.MessageKeys.emptyText)
        // Views
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                                     self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                                     self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                                     self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)])
        // Information
        self.presenter.getShiftsInformation()
    }
}

// MARK: - UITableView's implementation
extension SHShiftsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SHKeys.shiftCellIdentifier, for: indexPath) as? SHShiftTableViewCell else { fatalError("Failed to load Shift cell") }
        cell.setupViews(from: self.presenter.item(indexPath.row))
        return cell
    }
}

// MARK: - SHShiftsView's implementation
extension SHShiftsViewController: SHShiftsView {
    func didRetrieveData() {
        self.tableView.reloadData()
    }
    
    func didAddedNewShift(in indexPath: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
}
