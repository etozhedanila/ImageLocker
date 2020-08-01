//
//  PhotoPickerAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class PhotoPickerAssembly {
    static func createPhotoPicker(appRouter: AppRouter, resultHandler: @escaping ([PhotoCellModel]) -> Void) -> PhotoPickerViewInput {
        let router = PhotoPickerRouter(router: appRouter)
        let dataManager = PhotoPickerDataManager()
        let presenter = PhotoPickerPresenter(dataManager: dataManager, router: router)
        let interactor = PhotoPickerInteractor()
        let viewController = PhotoPickerViewController()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.resultHandler = resultHandler
        viewController.presenter = presenter
        dataManager.delegate = presenter
        return viewController
    }
}
