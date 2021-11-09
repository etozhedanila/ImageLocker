//
//  PhotoPreviewPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol PhotoPreviewViewOutput: AnyObject {
    
    var view: PhotoPreviewViewInput? { get set }
    var dataManager: PhotoPreviewDataManager { get }
    var selectedPhotoIndex: Int { get set }
    var photos: [SavedPhotoCellModel] { get }
    
    func viewDidLoad(_ view: PhotoPreviewViewInput)
    func viewDidTapClose(_ view: PhotoPreviewViewInput)
}

class PhotoPreviewPresenter: PhotoPreviewViewOutput {
    
    weak var view: PhotoPreviewViewInput?
    var dataManager: PhotoPreviewDataManager
    
    var selectedPhotoIndex: Int = 0 {
        didSet {
            let title = "\(selectedPhotoIndex + 1) из \(photos.count)"
            view?.configure(title: title)
        }
    }
    
    var photos: [SavedPhotoCellModel]
    private let router: PhotoPreviewRouter
    
    init(dataManager: PhotoPreviewDataManager, router: PhotoPreviewRouter, photos:[SavedPhotoCellModel]) {
        self.dataManager = dataManager
        self.router = router
        self.photos = photos
    }
    
    func viewDidLoad(_ view: PhotoPreviewViewInput) {
        let confs = photos.map { ImagePreviewCellConfigurator(model: $0) }
        dataManager.items.append(contentsOf: confs)
        view.reload()
        view.set(page: selectedPhotoIndex)
    }
    
    func viewDidTapClose(_ view: PhotoPreviewViewInput) {
        router.close()
    }
}

// MARK: - PhotoPreviewDataManagerDelegate
extension PhotoPreviewPresenter: PhotoPreviewDataManagerDelegate {
    
    func dataManager(_ dataManager: PhotoPreviewDataManager, didScrollToItemAtIndex index: Int) {
        selectedPhotoIndex = index
    }
}
