//
//  PhotoPreviewAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class PhotoPreviewAssembly {
    static func createPhotoPreview(appRouter: AppRouter, selectedPhotoIndex: Int, photos: [PhotoCellModel]) -> PhotoPreviewViewInput {
        let dataManager = PhotoPreviewDataManager()
        let presenter = PhotoPreviewPresenter(dataManager: dataManager, photos: photos)
        let viewController = PhotoPreviewViewController()
        
        dataManager.delegate = presenter
        presenter.selectedPhotoIndex = selectedPhotoIndex
        presenter.view = viewController
        viewController.presenter = presenter
        
        return viewController
    }
}
