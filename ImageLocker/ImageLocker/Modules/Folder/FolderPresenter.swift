//
//  FolderPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 25.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol FolderViewOutput: class {
    var view: FolderViewInput? { get set }
    var dataManager: FolderDataManager { get }
    
    func viewDidLoad(_ view: FolderViewInput)
}

class FolderPresenter: FolderViewOutput {
    var dataManager: FolderDataManager
    weak var view: FolderViewInput?
    let router: FolderRouter
    var interactor: FolderInteractorInput?
    var folder: FolderModel
    
    init(router: FolderRouter, dataManager: FolderDataManager, folder: FolderModel) {
        self.dataManager = dataManager
        self.router = router
        self.folder = folder
    }
    
    func viewDidLoad(_ view: FolderViewInput) {
        view.configure(title: folder.name)
    }
}

extension FolderPresenter: FolderInteractorOutput {
    
}

extension FolderPresenter: FolderDataManagerDelegate {
    
}
