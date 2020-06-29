//
//  CreatePinPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

//TODO: ADD Touch ID/ FACE ID
//      ADD Enter pincode screen

protocol CreatePinViewOutput: class {
    var view: CreatePinViewInput? { get set }
    
    func viewDidLoad(_ view: CreatePinViewInput)
}

class CreatePinPresenter: CreatePinViewOutput {
    weak var view: CreatePinViewInput?
    var interactor: CreatePinInteractorInput?
    let router: CreatePinRouter
    var pincode = ""
    
    init(router: CreatePinRouter) {
        self.router = router
    }
    
    func viewDidLoad(_ view: CreatePinViewInput) {
        if !pincode.isEmpty {
            view.setupAsConfirm()
        }
    }
}

extension CreatePinPresenter: CreatePinInteractorOutput {
    func interactorDidSavePincode(_ interactor: CreatePinInteractorInput) {
        print("saved")
    }
}

extension CreatePinPresenter: PincodeViewDelegate {
    func pincodeView(_ pincodeView: PincodeView, didFinishEnterPincode pincode: String) {
        if self.pincode.isEmpty {
            router.showConfirmPincode(pincode: pincode)
        } else if self.pincode == pincode {
            interactor?.save(pincode: pincode)
        } else {
            router.showCreatePincode()
        }
    }
}
