//
//  FolderDataManager.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 25.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol FolderDataManagerDelegate: class {
    
}

class FolderDataManager: BaseTableDataManager {
    weak var delegate: FolderDataManagerDelegate?
}
