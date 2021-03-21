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

    func fetchPhotos(folder: FolderModel)
    func save(folder: FolderModel, photos: [PhotoCellModel])
}

protocol FolderInteractorOutput: class {
    
    func interacor(_ interactor: FolderInteractorInput, didReceivePhotos photos: [PhotoCellModel])
    func interacor(_ interactor: FolderInteractorInput, didSavePhotos photos: [PhotoCellModel])
}

class FolderInteractor: FolderInteractorInput {
    
    weak var presenter: FolderInteractorOutput?
    private let fileManager = FileManager.default

    func fetchPhotos(folder: FolderModel) {
        guard let documents = getDocumentsDirectory() else { return }
        let filePath =  documents.appendingPathComponent("\(folder.name)").path
        guard fileManager.fileExists(atPath: filePath) else { fatalError("folder is not exist") }
        guard let folderUrl = URL(string: filePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil)
            let photoModels = fileURLs.map {
                PhotoCellModel(url: $0)
            }
            presenter?.interacor(self, didReceivePhotos: photoModels)
        } catch {
            print("failed to fetch content of directory ", error.localizedDescription)
        }
    }

    func save(folder: FolderModel, photos: [PhotoCellModel]) {
        let imagesData = photos.compactMap {
            $0.image?.jpegData(compressionQuality: 1.0)
        }
        
        guard let documents = getDocumentsDirectory() else { return }
        let filePath =  documents.appendingPathComponent("\(folder.name)").path
        guard fileManager.fileExists(atPath: filePath) else { fatalError("folder is not exist") }
        
        imagesData.forEach {
            let name = UUID().uuidString + ".jpg"
            guard let fileName = URL(string: "file://\(filePath)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)?.appendingPathComponent(name) else { return }
            do {
                try $0.write(to: fileName)
            } catch {
                print("Failed to save image ", error.localizedDescription)
            }
        }
        
        presenter?.interacor(self, didSavePhotos: photos)
    }
    
    private func getDocumentsDirectory() -> URL? {
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documents = paths.first else { return nil }
        return documents
    }
}
