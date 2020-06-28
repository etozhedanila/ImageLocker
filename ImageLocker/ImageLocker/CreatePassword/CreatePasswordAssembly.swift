//
//  CreatePasswordAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class CreatePasswordAssembly {
    static func createPassword() -> CreatePasswordViewInput {
        let router = CreatePasswordRouter()
        let presenter = CreatePasswordPresenter(router: router)
        let interactor = CreatePasswordInteractor()
        let viewController = CreatePasswordViewController()
        presenter.interactor = interactor
        presenter.view = viewController
        interactor.presenter = presenter
        viewController.presenter = presenter
        return viewController
    }
}
