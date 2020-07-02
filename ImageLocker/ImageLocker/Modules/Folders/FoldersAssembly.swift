//
//  FoldersAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class FoldersAssembly {
    static func createFolders(appRouter: AppRouter) -> FoldersViewInput {
        let router = FoldersRouter(router: appRouter)
        let interactor = FoldersInteractor()
        let presenter = FoldersPresenter(router: router)
        let viewController = FoldersViewController()
        
        presenter.interactor = interactor
        presenter.view = viewController
        interactor.presenter = presenter
        viewController.presenter = presenter
        
        return viewController
    }
}
