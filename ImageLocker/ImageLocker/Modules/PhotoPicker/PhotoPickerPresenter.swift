//
//  PhotoPickerPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Photos

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
        view.showLoading()
        interactor?.fetchAssets()
    }

    func viewDidEndPicking(_ view: PhotoPickerViewInput) {
        resultHandler?(selectedPhotos)
        router.close()
    }
}

// MARK: - PhotoPickerInteractorOutput
extension PhotoPickerPresenter: PhotoPickerInteractorOutput {
    
    func interactor(_ interactor: PhotoPickerInteractorInput, didReceiveAssets assets: [PHAsset]) {
        PhotosCacheManager.shared.startCaching(assets: assets)
        let models = assets.map { PhotoCellModel(asset: $0) }
        let confs = models.map { PhotoCellConfigurator(model: $0) }
        dataManager.items.append(contentsOf: confs)
        DispatchQueue.main.async {
            self.view?.stopLoading()
            self.view?.reload()
        }
    }
}

// MARK: - PhotoPickerDataManagerDelegate
extension PhotoPickerPresenter: PhotoPickerDataManagerDelegate {
    
    func dataManager(_ dataManager: PhotoPickerDataManager, didSelectPhotoAt index: Int) {
        (dataManager.items[index] as? PhotoCellConfigurator)?.model.isSelected.toggle()
        guard let photoModel = (dataManager.items[index] as? PhotoCellConfigurator)?.model else { return }
        if photoModel.isSelected {
            selectedPhotos.append(photoModel)
        } else {
            guard let selectedIndex = selectedPhotos.firstIndex(where: { $0.id == photoModel.id }) else { return }
            selectedPhotos.remove(at: selectedIndex)
        }
        DispatchQueue.main.async {
            self.view?.updateCell(at: index, isSelected: photoModel.isSelected)
        }
    }
}
