//
//  FoldersPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol FoldersViewOutput: class {
    var view: FoldersViewInput? { get set }
    var dataManager: FoldersDataManager { get }
    
    func viewDidLoad(_ view: FoldersViewInput)
    func viewDidShowCreateFolder(_ view: FoldersViewInput)
}

class FoldersPresenter: FoldersViewOutput {
    var dataManager: FoldersDataManager
    weak var view: FoldersViewInput?
    var interactor: FoldersInteractorInput?
    private let router: FoldersRouter
    
    
    init(router: FoldersRouter, dataManager: FoldersDataManager) {
        self.router = router
        self.dataManager = dataManager
    }
    
    func viewDidLoad(_ view: FoldersViewInput) {
        
    }
    
    func viewDidShowCreateFolder(_ view: FoldersViewInput) {
        router.showFolderCreation() { [weak self] name in
            guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
            self?.interactor?.createFolder(name: name)
        }
    }
}

extension FoldersPresenter: FoldersInteractorOutput {
    func interactor(_ interactor: FoldersInteractorInput, didCreateFolder name: String) {
        let model = FolderCellModel(name: name)
        let folderConfigurator = FolderCellConfigurator(model: model)
        dataManager.items.append(folderConfigurator)
        let insertionIndex = dataManager.items.count - 1
        view?.perform(editing: [.init(position: insertionIndex, editionType: .insert)])
    }
}

extension FoldersPresenter: FoldersDataManagerDelegate {
    func dataManager(_ dataManager: FoldersDataManager, didSelectFolderAt row: Int) {
        
    }
}
