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
    func viewDidTapAddImage(_ view: FolderViewInput)
}

class FolderPresenter: FolderViewOutput {
    var dataManager: FolderDataManager
    weak var view: FolderViewInput?
    let router: FolderRouter
    var interactor: FolderInteractorInput?
    var folder: FolderModel
    private var photos: [PhotoCellModel] = []

    init(router: FolderRouter, dataManager: FolderDataManager, folder: FolderModel) {
        self.dataManager = dataManager
        self.router = router
        self.folder = folder
    }

    func viewDidLoad(_ view: FolderViewInput) {
        view.configure(title: folder.name)
        interactor?.fetchPhotos()
    }

    func viewDidTapAddImage(_ view: FolderViewInput) {
        router.openPhotoLibrary { [weak self] photos in
            self?.interactor?.save(photos: photos)
        }
    }

    private func insert(photos: [PhotoCellModel]) {
        let confs = photos.map { PhotoCellConfigurator(model: $0) }
        dataManager.items.append(contentsOf: confs)
        self.photos.append(contentsOf: photos)
        DispatchQueue.main.async {
            self.view?.reload()
        }
    }
}

extension FolderPresenter: FolderInteractorOutput {
    func interacor(_ interactor: FolderInteractorInput, didReceivePhotos photos: [PhotoCellModel]) {
        self.photos = photos
        let confs = photos.map { PhotoCellConfigurator(model: $0) }
        dataManager.items.append(contentsOf: confs)
        view?.reload()
    }

    func interacor(_ interactor: FolderInteractorInput, didSavePhotos photos: [PhotoCellModel]) {
        insert(photos: photos)
    }
}

extension FolderPresenter: FolderDataManagerDelegate {
    func dataManager(_ dataManager: FolderDataManager, didSelectPhotoAt index: Int) {
        router.preview(photos: photos, selectedPhotoIndex: index)
    }
}
