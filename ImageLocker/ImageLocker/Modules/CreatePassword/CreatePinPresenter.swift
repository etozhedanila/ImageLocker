//
//  CreatePinPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol CreatePinViewOutput: class {
    var view: CreatePinViewInput? { get set }
    func viewDidLoad(_ view: CreatePinViewInput)
}

class CreatePinPresenter: CreatePinViewOutput {
    weak var view: CreatePinViewInput?
    var interactor: CreatePinInteractorInput?
    let router: CreatePinRouter
    
    init(router: CreatePinRouter) {
        self.router = router
    }
    
    func viewDidLoad(_ view: CreatePinViewInput) {
        
    }
}

extension CreatePinPresenter: CreatePinInteractorOutput {
    func interactorDidSavePincode(_ interactor: CreatePinInteractorInput) {
        
    }
}

extension CreatePinPresenter: PincodeViewDelegate {
    func pincodeView(_ pincodeView: PincodeView, didFinishEnterPincode pincode: String) {
        interactor?.save(pincode: pincode)
    }
}
