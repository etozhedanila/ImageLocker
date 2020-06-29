//
//  CreatePinAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class CreatePinAssembly {
    private var pincode = ""
    init(pincode: String = "") {
        self.pincode = pincode
    }
    
    func createPin(appRouter: AppRouter) -> CreatePinViewInput {
        let router = CreatePinRouter(router: appRouter)
        let presenter = CreatePinPresenter(router: router)
        let interactor = CreatePinInteractor()
        let viewController = CreatePinViewController()
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.pincode = pincode
        interactor.presenter = presenter
        viewController.presenter = presenter
        return viewController
    }
}
