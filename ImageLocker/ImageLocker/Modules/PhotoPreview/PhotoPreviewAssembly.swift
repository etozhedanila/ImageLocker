//
//  PhotoPreviewAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class PhotoPreviewAssembly {
    
    private let photos: [SavedPhotoCellModel]
    private let selectedPhotoIndex: Int
    
    init(photos: [SavedPhotoCellModel], selectedPhotoIndex: Int = 0) {
        self.photos = photos
        self.selectedPhotoIndex = selectedPhotoIndex
    }
    
    func createPhotoPreview(appRouter: AppRouter) -> PhotoPreviewViewInput {
        let dataManager = PhotoPreviewDataManager()
        let router = PhotoPreviewRouter(router: appRouter)
        let presenter = PhotoPreviewPresenter(dataManager: dataManager, router: router, photos: photos)
        let viewController = PhotoPreviewViewController()
        
        dataManager.delegate = presenter
        presenter.view = viewController
        presenter.selectedPhotoIndex = selectedPhotoIndex
        viewController.presenter = presenter
        
        return viewController
    }
}
