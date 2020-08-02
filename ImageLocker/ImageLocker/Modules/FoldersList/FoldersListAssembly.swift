//
//  FoldersListAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class FoldersListAssembly {
    static func createFolders(appRouter: AppRouter) -> FoldersListViewInput {
        let router = FoldersListRouter(router: appRouter)
        let dataManager = FoldersListDataManager()
        let interactor = FoldersListInteractor()
        let presenter = FoldersListPresenter(router: router, dataManager: dataManager)
        let viewController = FoldersListViewController()

        presenter.interactor = interactor
        presenter.view = viewController
        interactor.presenter = presenter
        viewController.presenter = presenter
        dataManager.delegate = presenter

        return viewController
    }
}
