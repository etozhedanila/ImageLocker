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
    
    func loadFolders()
    func createFolder(name: String)
}

protocol FoldersListInteractorOutput: class {
    func interactor(_ interactor: FoldersListInteractorInput, didLoadDirectories directories: [String])
    func interactor(_ interactor: FoldersListInteractorInput, didCreateFolder name: String)
}

class FoldersListInteractor: FoldersListInteractorInput {
    weak var presenter: FoldersListInteractorOutput?
    private let fileManager = FileManager.default
    
    func loadFolders() {
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let documentsPath = documents.path
        let directories = try? fileManager.contentsOfDirectory(atPath: documentsPath)
        presenter?.interactor(self, didLoadDirectories: directories ?? [])
    }
    
    func createFolder(name: String) {
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let filePath =  documents.appendingPathComponent("\(name)")
        if !fileManager.fileExists(atPath: filePath.path) {
            do {
                try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                presenter?.interactor(self, didCreateFolder: name)
            } catch {
                print("Couldn't create document directory")
            }
        }
    }
}
