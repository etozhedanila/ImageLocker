//
//  FoldersListRouter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class FoldersListRouter: RouterInterface {
    let router: AppRouter
    
    private enum LocalizedString {
        static let createFolder = "Создать новую папку"
    }
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func showFolderCreation(resultHandler: @escaping (String) -> Void) {
        let alert = CreateFolderAlert()
        alert.alertTitle = LocalizedString.createFolder
        alert.resultHandler = resultHandler
        alert.modalPresentationStyle = .overCurrentContext
        router.present(viewController: alert, animated: false)
    }
    
    func openFolder(name: String) {
        
    }
}
