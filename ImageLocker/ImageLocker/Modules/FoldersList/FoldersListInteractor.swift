//
//  FoldersListInteractor.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol FoldersListInteractorInput: class {
    var presenter: FoldersListInteractorOutput? { get set }
    func createFolder(name: String)
}

protocol FoldersListInteractorOutput: class {
    func interactor(_ interactor: FoldersListInteractorInput, didCreateFolder name: String)
}

class FoldersListInteractor: FoldersListInteractorInput {
    weak var presenter: FoldersListInteractorOutput?
    private let fileManager = FileManager.default
    
    func createFolder(name: String) {
        
        presenter?.interactor(self, didCreateFolder: name)
    }
}
