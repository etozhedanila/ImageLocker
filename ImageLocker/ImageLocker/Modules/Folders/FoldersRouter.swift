//
//  FoldersRouter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class FoldersRouter: RouterInterface {
    let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func showFolderCreation() {
        let alert = CreateFolderAlert()
        alert.modalPresentationStyle = .overCurrentContext
        router.present(viewController: alert, animated: false)
    }
}
