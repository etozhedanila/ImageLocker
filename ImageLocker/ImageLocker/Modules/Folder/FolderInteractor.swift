//
//  FolderInteractor.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 25.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Photos

protocol FolderInteractorInput: class {
    
    var presenter: FolderInteractorOutput? { get set }

    func fetchPhotos(folder: FolderModel)
    func save(folder: FolderModel, photos: [PhotoCellModel])
}

protocol FolderInteractorOutput: class {
    
    func interacor(_ interactor: FolderInteractorInput, didReceivePhotos photos: [SavedPhotoCellModel])
    func interacor(_ interactor: FolderInteractorInput, didSavePhotosWithUrls urls: [URL])
}

class FolderInteractor: FolderInteractorInput {
    
    weak var presenter: FolderInteractorOutput?
    private let fileManager = FileManager.default
    
    private let fetchPhotosUrlsQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.vitalySubbotin.ImageLocker.FolderInteractor.fetchPhotosUrlsQueue"
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        return queue
    }()

    func fetchPhotos(folder: FolderModel) {
        guard let documents = getDocumentsDirectory() else { return }
        let filePath =  documents.appendingPathComponent("\(folder.name)").path
        guard fileManager.fileExists(atPath: filePath) else { fatalError("folder is not exist") }
        guard let folderUrl = URL(string: filePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil)
            let photoModels = fileURLs.map {
                SavedPhotoCellModel(url: $0)
            }
            presenter?.interacor(self, didReceivePhotos: photoModels)
        } catch {
            print("failed to fetch content of directory ", error.localizedDescription)
        }
    }

    
    func save(folder: FolderModel, photos: [PhotoCellModel]) {
        let assets = photos.compactMap { $0.asset }
        var urls: [URL] = []
        assets.forEach { asset in
            let operation = FetchPhotoUrlOperation(asset: asset) { (url) in
                guard let url = url else { return }
                urls.append(url)
            }
            self.fetchPhotosUrlsQueue.addOperation(operation)
        }
        
        self.fetchPhotosUrlsQueue.addOperation {
            let imagesData = urls
                .compactMap { try? Data(contentsOf: $0) }
            
            guard let documents = self.getDocumentsDirectory() else { return }
            let filePath =  documents.appendingPathComponent("\(folder.name)").path
            guard self.fileManager.fileExists(atPath: filePath) else { fatalError("folder is not exist") }
            var imageUrls: [URL] = []
            imagesData.forEach {
                let name = UUID().uuidString + ".jpg"
                guard let fileName = URL(string: "file://\(filePath)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)?.appendingPathComponent(name) else { return }
                do {
                    try $0.write(to: fileName)
                    imageUrls.append(fileName)
                } catch {
                    print("Failed to save image ", error.localizedDescription)
                }
            }
            
            self.presenter?.interacor(self, didSavePhotosWithUrls: imageUrls)
        }
    }
    
    private func getDocumentsDirectory() -> URL? {
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documents = paths.first else { return nil }
        return documents
    }
}
