//
//  CreatePinInteractor.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol CreatePinInteractorInput: class {
    var presenter: CreatePinInteractorOutput? { get set }

    func save(pincode: String)
}

protocol CreatePinInteractorOutput: class {
    func interactorDidSavePincode(_ interactor: CreatePinInteractorInput)
}

class CreatePinInteractor: CreatePinInteractorInput {
    weak var presenter: CreatePinInteractorOutput?

    func save(pincode: String) {
        let ud = UserDefaults.standard
        ud.set(pincode, forKey: pincodeKey)
        presenter?.interactorDidSavePincode(self)
    }
}
