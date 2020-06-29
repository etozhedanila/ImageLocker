//
//  EnterPincodeInteractor.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 29.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol EnterPincodeInteractorInput: class {
    var presenter: EnterPincodeInteractorOutput? { get set }
    
    func check(pincode: String)
}

protocol EnterPincodeInteractorOutput: class {
    func interactor(_ interactor: EnterPincodeInteractorInput, didCompressSuccessful isSuccess: Bool)
}

class EnterPincodeInteractor: EnterPincodeInteractorInput {
    weak var presenter: EnterPincodeInteractorOutput?
    
    func check(pincode: String) {
        
    }
}
