//
//  CreatePinAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class CreatePinAssembly {
    static func createPin() -> CreatePinViewInput {
        let router = CreatePinRouter()
        let presenter = CreatePinPresenter(router: router)
        let interactor = CreatePinInteractor()
        let viewController = CreatePinViewController()
        presenter.interactor = interactor
        presenter.view = viewController
        interactor.presenter = presenter
        viewController.presenter = presenter
        return viewController
    }
}
