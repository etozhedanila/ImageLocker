//
//  FolderPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 25.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol FolderViewOutput: AnyObject {
    
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

    init(router: FolderRouter, dataManager: FolderDataManager, folder: FolderModel) {
        self.dataManager = dataManager
        self.router = router
        self.folder = folder
    }

    func viewDidLoad(_ view: FolderViewInput) {
        view.configure(title: folder.name)
        view.showLoading()
        DispatchQueue.global(qos: .utility).async {
            self.interactor?.fetchPhotos(folder: self.folder)
        }
    }

    func viewDidTapAddImage(_ view: FolderViewInput) {
        router.openPhotoLibrary { [weak self] photos in
            guard let self = self else { return }
            self.interactor?.save(folder: self.folder, photos: photos)
        }
    }
}

// MARK: - FolderInteractorOutput
extension FolderPresenter: FolderInteractorOutput {

    func interacor(_ interactor: FolderInteractorInput, didReceivePhotos photos: [SavedPhotoCellModel]) {
        let confs = photos.map { SavedPhotoCellConfigurator(model: $0) }
        dataManager.items.append(contentsOf: confs)
        DispatchQueue.main.async {
            self.view?.stopLoading()
            self.view?.reload()
        }
    }
    
    func interacor(_ interactor: FolderInteractorInput, didSavePhotosWithUrls urls: [URL]) {
        let models = urls.map { SavedPhotoCellModel(url: $0) }
        let confs = models.map { SavedPhotoCellConfigurator(model: $0) }
        dataManager.items.append(contentsOf: confs)
        DispatchQueue.main.async {
            self.view?.reload()
        }
    }
}

// MARK: - FolderDataManagerDelegate
extension FolderPresenter: FolderDataManagerDelegate {
    
    func dataManager(_ dataManager: FolderDataManager, didSelectPhotoAt index: Int) {
        let photos = dataManager.items.compactMap { ($0 as? SavedPhotoCellConfigurator)?.model }
        router.preview(photos: photos, selectedPhotoIndex: index)
    }
}
