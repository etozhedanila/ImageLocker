//
//  PhotoPickerInteractor.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit
import Photos

protocol PhotoPickerInteractorInput: class {
    
    var presenter: PhotoPickerInteractorOutput? { get set }

    func fetchPhotos(photoSize: CGSize)
}

protocol PhotoPickerInteractorOutput: class {
    
    func interactor(_ interactor: PhotoPickerInteractorInput, didReceivePhotos photos: [UIImage])
}

class PhotoPickerInteractor: PhotoPickerInteractorInput {
    
    weak var presenter: PhotoPickerInteractorOutput?
    
    private let fetchPhotosQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.vitalySubbotin.ImageLocker.PhotoPickerInteractor.fetchPhotosQueue"
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        return queue
    }()

    func fetchPhotos(photoSize: CGSize) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        guard fetchResult.count > 0 else {
            presenter?.interactor(self, didReceivePhotos: [])
            return
        }
        var images: [UIImage] = []
        let indexes = IndexSet(integersIn: 0..<fetchResult.count)
        fetchResult.objects(at: indexes).enumerated().forEach { (index, asset) in
            let fetchPhotoOperation = FetchPhotoOperation(asset: asset, size: photoSize) { (image) in
                guard let image = image else { return }
                images.append(image)
            }
            self.fetchPhotosQueue.addOperation(fetchPhotoOperation)
            if (index+1).isMultiple(of: 100), index > 0 {
                self.fetchPhotosQueue.addOperation { [weak self] in
                    guard let self = self else { return }
                    self.presenter?.interactor(self, didReceivePhotos: images)
                    images.removeAll()
                }
            }
        }
        
        fetchPhotosQueue.addOperation { [weak self] in
            guard let self = self, !images.isEmpty else { return }
            self.presenter?.interactor(self, didReceivePhotos: images)
        }
    }
}
