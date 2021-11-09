//
//  TableEditable.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

struct TableEdition {
    
    var position: Int
    var editionType: EditionType
}

enum EditionType {
    
    case insert
    case remove
    case update
}

protocol TableEditable: AnyObject {
    
    var tableView: UITableView { get }
}

extension TableEditable {
    
    func reload() {
        tableView.reloadData()
    }

    func perform(editing: [TableEdition], completion: ((Bool) -> Void)? = nil) {
        let updates = editing.filter { $0.editionType == .update }
        let updateRows = updates.map { IndexPath(row: $0.position, section: 0) }

        let deletions = editing.filter { $0.editionType == .remove }
        let deletionRows = deletions.map { IndexPath(row: $0.position, section: 0) }

        let insertions = editing.filter { $0.editionType == .insert }
        let insertionRows = insertions.map { IndexPath(row: $0.position, section: 0) }

        tableView.performBatchUpdates({
            if !updateRows.isEmpty {
                tableView.reloadRows(at: updateRows, with: .none)
            }

            if !deletionRows.isEmpty {
                tableView.deleteRows(at: deletionRows, with: .right)
            }

            if !insertionRows.isEmpty {
                tableView.insertRows(at: insertionRows, with: .fade)
            }
        }, completion: completion)
    }
}
