//
//  PhotoPreviewRouter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 22.03.2021.
//  Copyright © 2021 Виталий Субботин. All rights reserved.
//

import Foundation

class PhotoPreviewRouter: RouterInterface {
    
    let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }

    func close() {
        router.pop(animated: true)
    }
}
