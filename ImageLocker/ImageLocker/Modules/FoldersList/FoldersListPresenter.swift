//
//  FoldersListPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol FoldersListViewOutput: class {
    var view: FoldersListViewInput? { get set }
    var dataManager: FoldersListDataManager { get }
    
    func viewDidLoad(_ view: FoldersListViewInput)
    func viewDidShowCreateFolder(_ view: FoldersListViewInput)
}

class FoldersListPresenter: FoldersListViewOutput {
    var dataManager: FoldersListDataManager
    weak var view: FoldersListViewInput?
    var interactor: FoldersListInteractorInput?
    private let router: FoldersListRouter
    
    
    init(router: FoldersListRouter, dataManager: FoldersListDataManager) {
        self.router = router
        self.dataManager = dataManager
    }
    
    func viewDidLoad(_ view: FoldersListViewInput) {
        
    }
    
    func viewDidShowCreateFolder(_ view: FoldersListViewInput) {
        router.showFolderCreation() { [weak self] name in
            guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
            self?.interactor?.createFolder(name: name)
        }
    }
}

extension FoldersListPresenter: FoldersListInteractorOutput {
    func interactor(_ interactor: FoldersListInteractorInput, didCreateFolder name: String) {
        let model = FolderModel(name: name)
        let folderConfigurator = FolderCellConfigurator(model: model)
        dataManager.items.append(folderConfigurator)
        let insertionIndex = dataManager.items.count - 1
        view?.perform(editing: [.init(position: insertionIndex, editionType: .insert)])
    }
}

extension FoldersListPresenter: FoldersListDataManagerDelegate {
    func dataManager(_ dataManager: FoldersListDataManager, didSelectFolderAt row: Int) {
        guard let folder = (dataManager.items[row] as? FolderCellConfigurator)?.model else { return }
        router.open(folder: folder)
    }
}
