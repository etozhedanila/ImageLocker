//
//  PhotoPreviewPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol PhotoPreviewViewOutput: class {
    var view: PhotoPreviewViewInput? { get set }
    var dataManager: PhotoPreviewDataManager { get }
    var selectedPhotoIndex: Int { get set }
    var photos: [PhotoCellModel] { get }
    
    func viewDidLoad(_ view: PhotoPreviewViewInput)
}

class PhotoPreviewPresenter: PhotoPreviewViewOutput {
    weak var view: PhotoPreviewViewInput?
    var dataManager: PhotoPreviewDataManager
    var selectedPhotoIndex: Int = 0
    var photos: [PhotoCellModel]
    
    init(dataManager: PhotoPreviewDataManager, photos:[PhotoCellModel]) {
        self.dataManager = dataManager
        self.photos = photos
    }
    
    func viewDidLoad(_ view: PhotoPreviewViewInput) {
        let confs = photos.map { ImagePreviewCellConfigurator(model: $0) }
        dataManager.items.append(contentsOf: confs)
        view.reload()
    }
}

extension PhotoPreviewPresenter: PhotoPreviewDataManagerDelegate {
    
}
