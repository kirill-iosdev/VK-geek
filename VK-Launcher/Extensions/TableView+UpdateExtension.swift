//
//  TableView+UpdateExtension.swift
//  VK-Launcher
//
//  Created by Kirill on 23.04.2022.
//

import UIKit

extension UITableView {
    func update(deletions: [Int], insertions: [Int], modifications: [Int], section: Int = 0) {
        beginUpdates()
        deleteRows(at: deletions.map { IndexPath(row: $0, section: section)}, with: .automatic)
        insertRows(at: insertions.map { IndexPath(row: $0, section: section)}, with: .automatic)
        reloadRows(at: modifications.map { IndexPath(row: $0, section: section)}, with: .automatic)
        endUpdates()
    }
}
