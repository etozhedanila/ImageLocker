//
//  CreatePasswordInteractor.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol CreatePasswordInteractorInput: class {
    var presenter: CreatePasswordInteractorOutput? { get set }
}

protocol CreatePasswordInteractorOutput: class {
    
}

class CreatePasswordInteractor: CreatePasswordInteractorInput {
    weak var presenter: CreatePasswordInteractorOutput?
    
}
