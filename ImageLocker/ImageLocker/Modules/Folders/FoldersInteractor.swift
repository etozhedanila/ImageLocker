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
    func createFolder(name: String)
}

protocol FoldersInteractorOutput: class {
    func interactor(_ interactor: FoldersInteractorInput, didCreateFolder name: String)
}

class FoldersInteractor: FoldersInteractorInput {
    weak var presenter: FoldersInteractorOutput?
    private let fileManager = FileManager.default
    
    func createFolder(name: String) {
        
        presenter?.interactor(self, didCreateFolder: name)
    }
}
