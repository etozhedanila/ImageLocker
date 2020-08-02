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

    func fetchPhotos()
    func save(photos: [PhotoCellModel])
}

protocol FolderInteractorOutput: class {
    func interacor(_ interactor: FolderInteractorInput, didReceivePhotos photos: [PhotoCellModel])
    func interacor(_ interactor: FolderInteractorInput, didSavePhotos photos: [PhotoCellModel])
}

class FolderInteractor: FolderInteractorInput {
    weak var presenter: FolderInteractorOutput?

    func fetchPhotos() {

    }

    func save(photos: [PhotoCellModel]) {

    }
}
