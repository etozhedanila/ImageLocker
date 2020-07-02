//
//  CreatePinRouter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

class CreatePinRouter: RouterInterface, RouteFolders {
    var router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func showConfirmPincode(pincode: String) {
        let vc = CreatePinAssembly(pincode: pincode).createPin(appRouter: router).viewController
        router.push(viewController: vc, animated: true)
    }
    
    func showCreatePincode() {
        router.pop(animated: true)
    }
}
