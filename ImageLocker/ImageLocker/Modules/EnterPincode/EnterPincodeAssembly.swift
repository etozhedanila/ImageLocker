//
//  EnterPincodeAssembly.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 29.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class EnterPincodeAssembly {
    private let pincode: String
    init(pincode: String) {
        self.pincode = pincode
    }
    
    func enterPincode(appRouter: AppRouter) -> EnterPincodeViewInput {
        let router = EnterPincodeRouter(router: appRouter)
        let interactor = EnterPincodeInteractor()
        let presenter = EnterPincodePresenter(router: router, pincode: self.pincode)
        let viewController = EnterPincodeViewController()
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }
}
