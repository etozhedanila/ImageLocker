//
//  PhotoPickerPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol PhotoPickerViewOutput: class {
    
    var view: PhotoPickerViewInput? { get set }
    var dataManager: PhotoPickerDataManager { get }

    func viewDidLoad(_ view: PhotoPickerViewInput)
    func viewDidEndPicking(_ view: PhotoPickerViewInput)
}

class PhotoPickerPresenter: PhotoPickerViewOutput {
    
    weak var view: PhotoPickerViewInput?
    var interactor: PhotoPickerInteractorInput?
    var dataManager: PhotoPickerDataManager
    var resultHandler: (([PhotoCellModel]) -> Void)?
    private let router: PhotoPickerRouter
    private var selectedPhotos: [PhotoCellModel] = []

    init(dataManager: PhotoPickerDataManager, router: PhotoPickerRouter) {
        self.dataManager = dataManager
        self.router = router
    }

    func viewDidLoad(_ view: PhotoPickerViewInput) {
        fetchPhotos()
    }

    func viewDidEndPicking(_ view: PhotoPickerViewInput) {
        selectedPhotos = dataManager.items
            .compactMap { ($0 as? PhotoCellConfigurator)?.model }
            .filter { $0.isSelected }
        resultHandler?(selectedPhotos)
        router.close()
    }

    private func fetchPhotos() {
        interactor?.fetchPhotos()
    }
}

extension PhotoPickerPresenter: PhotoPickerInteractorOutput {
    
    func interactor(_ interactor: PhotoPickerInteractorInput, didReceivePhotos photos: [UIImage]) {
        let models = photos.map { PhotoCellModel(image: $0) }
        let confs = models.map { PhotoCellConfigurator(model: $0) }
        dataManager.items.append(contentsOf: confs)
        DispatchQueue.main.async {
            self.view?.reload()
        }
    }
}

extension PhotoPickerPresenter: PhotoPickerDataManagerDelegate {
    
    func dataManager(_ dataManager: PhotoPickerDataManager, didSelectPhotoAt index: Int) {
        (dataManager.items[index] as? PhotoCellConfigurator)?.model.isSelected.toggle()
    }
}
