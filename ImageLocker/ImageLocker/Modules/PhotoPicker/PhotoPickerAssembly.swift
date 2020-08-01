//
//  PhotoPickerAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class PhotoPickerAssembly {
    static func createPhotoPicker(appRouter: AppRouter) -> PhotoPickerViewInput {
        let router = PhotoPickerRouter(router: appRouter)
        let dataManager = PhotoPickerDataManager()
        let presenter = PhotoPickerPresenter(dataManager: dataManager, router: router)
        let viewController = PhotoPickerViewController()
        
        presenter.view = viewController
        viewController.presenter = presenter
        dataManager.delegate = presenter
        return viewController
    }
}
