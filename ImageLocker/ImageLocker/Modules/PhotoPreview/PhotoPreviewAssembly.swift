//
//  PhotoPreviewAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class PhotoPreviewAssembly {
    
    private let photos: [PhotoCellModel]
    private let selectedPhotoIndex: Int
    
    init(photos: [PhotoCellModel], selectedPhotoIndex: Int = 0) {
        self.photos = photos
        self.selectedPhotoIndex = selectedPhotoIndex
    }
    
    func createPhotoPreview(appRouter: AppRouter) -> PhotoPreviewViewInput {
        let dataManager = PhotoPreviewDataManager()
        let router = PhotoPreviewRouter(router: appRouter)
        let presenter = PhotoPreviewPresenter(dataManager: dataManager, router: router, photos: photos)
        let viewController = PhotoPreviewViewController()
        
        dataManager.delegate = presenter
        presenter.selectedPhotoIndex = selectedPhotoIndex
        presenter.view = viewController
        viewController.presenter = presenter
        
        return viewController
    }
}
