//
//  FolderAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 25.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class FolderAssembly {
    
    private let folder: FolderModel

    init(folder: FolderModel) {
        self.folder = folder
    }

    func createFolders(appRouter: AppRouter) -> FolderViewInput {
        let router = FolderRouter(router: appRouter)
        let dataManager = FolderDataManager()
        let interactor = FolderInteractor()
        let presenter = FolderPresenter(router: router, dataManager: dataManager, folder: folder)
        let viewController = FolderViewController()

        presenter.interactor = interactor
        presenter.view = viewController
        interactor.presenter = presenter
        viewController.presenter = presenter
        dataManager.delegate = presenter

        return viewController
    }
}
