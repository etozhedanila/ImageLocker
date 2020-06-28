//
//  CreatePasswordPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol CreatePasswordViewOutput: class {
    var view: CreatePasswordViewInput? { get set }
    func viewDidLoad(_ view: CreatePasswordViewInput)
}

class CreatePasswordPresenter: CreatePasswordViewOutput {
    weak var view: CreatePasswordViewInput?
    var interactor: CreatePasswordInteractorInput?
    let router: CreatePasswordRouter
    
    init(router: CreatePasswordRouter) {
        self.router = router
    }
    
    func viewDidLoad(_ view: CreatePasswordViewInput) {
        
    }
}

extension CreatePasswordPresenter: CreatePasswordInteractorOutput {
    
}
