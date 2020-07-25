//
//  FolderInteractor.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 25.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol FolderInteractorInput: class {
    var presenter: FolderInteractorOutput? { get set }
}

protocol FolderInteractorOutput: class {
    
}

class FolderInteractor: FolderInteractorInput{
    weak var presenter: FolderInteractorOutput?
    
}
