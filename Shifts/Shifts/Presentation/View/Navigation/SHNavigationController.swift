//
//  SHNavigationController.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import UIKit

class SHNavigationController: UINavigationController {
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.configureBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureBar()
    }
    
    // MARK: - Setup
    private func configureBar() {
        self.navigationBar.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.compactAppearance = navBarAppearance
    }
}
