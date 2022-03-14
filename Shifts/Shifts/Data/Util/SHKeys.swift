//
//  SHKeys.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import UIKit

struct SHKeys {
    // Cell
    static let shiftCellIdentifier = "shiftCell"
    
    // MARK: - Message keys
    struct MessageKeys {
        static let emptyText = ""
        // Shift List
        static let shiftListControllerTitle = "SH_SHIFT_LIST_CONTROLLER_NAME"
        // Add Shift
        static let addShiftControllerTitle = "SH_ADD_SHIFT_CONTROLLER_NAME"
    }
    
    // MARK: - Colors
    struct Colors {
        static func color(fromName name: String) -> UIColor {
            let colors: [String: UIColor] = ["red": .red,
                                             "blue": .blue,
                                             "green": .green]
            return colors[name] ?? .clear
        }
    }
}
