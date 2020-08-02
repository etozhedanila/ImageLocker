//
//  EnterPincodePresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 29.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol EnterPincodeViewOutput: class {
    var view: EnterPincodeViewInput? { get set }
    func viewDidLoad(_ view: EnterPincodeViewInput)
    func viewDidPassAuth(_ view: EnterPincodeViewInput)
}

class EnterPincodePresenter: EnterPincodeViewOutput {
    weak var view: EnterPincodeViewInput?
    let router: EnterPincodeRouter
    let pincode: String
    var interactor: EnterPincodeInteractorInput?

    init(router: EnterPincodeRouter, pincode: String) {
        self.router = router
        self.pincode = pincode
    }

    func viewDidLoad(_ view: EnterPincodeViewInput) {

    }

    func viewDidPassAuth(_ view: EnterPincodeViewInput) {
        router.showFolders()
    }
}

extension EnterPincodePresenter: EnterPincodeInteractorOutput {
    func interactor(_ interactor: EnterPincodeInteractorInput, didCompressSuccessful isSuccess: Bool) {
        if isSuccess {
            router.showFolders()
        } else {
            view?.reset()
        }
    }
}

extension EnterPincodePresenter: PincodeViewDelegate {
    func pincodeView(_ pincodeView: PincodeView, didFinishEnterPincode pincode: String) {
        interactor?.check(pincode: pincode)
    }
}
