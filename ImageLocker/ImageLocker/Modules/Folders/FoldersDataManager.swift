//
//  FoldersDataManager.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol FoldersDataManagerDelegate: class {
    func dataManager(_ dataManager: FoldersDataManager, didSelectFolderAt row: Int)
}

class FoldersDataManager: BaseTableDataManager {
    weak var delegate: FoldersDataManagerDelegate?
}

extension FoldersDataManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.dataManager(self, didSelectFolderAt: indexPath.row)
    }
}
