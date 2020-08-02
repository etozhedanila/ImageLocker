//
//  FoldersListDataManager.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol FoldersListDataManagerDelegate: class {
    func dataManager(_ dataManager: FoldersListDataManager, didSelectFolderAt row: Int)
    func dataManager(_ dataManager: FoldersListDataManager, didRemoveDirectoryAt row: Int)
}

class FoldersListDataManager: BaseTableDataManager {
    weak var delegate: FoldersListDataManagerDelegate?
}

extension FoldersListDataManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.row].height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.dataManager(self, didSelectFolderAt: indexPath.row)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.dataManager(self, didRemoveDirectoryAt: indexPath.row)
        }
    }
}
