//
//  FoldersInteractor.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol FoldersInteractorInput: class {
    var presenter: FoldersInteractorOutput? { get set }
}

protocol FoldersInteractorOutput: class {
    
}

class FoldersInteractor: FoldersInteractorInput {
    weak var presenter: FoldersInteractorOutput?
    
    
}
