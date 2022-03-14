//
//  ShiftsViewController.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/11/22.
//

import UIKit

class ShiftsViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - View Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(SHShiftTableViewCell.self, forCellReuseIdentifier: SHKeys.shiftCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.title = NSLocalizedString(SHKeys.MessageKeys.shiftListControllerTitle, comment: SHKeys.MessageKeys.emptyText)
    }
}

// MARK: - UITableView's implementation
extension ShiftsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
