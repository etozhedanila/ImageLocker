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

    func fetchPhotos()
}

protocol PhotoPickerInteractorOutput: class {
    
    func interactor(_ interactor: PhotoPickerInteractorInput, didReceivePhotos photos: [UIImage])
}

class PhotoPickerInteractor: PhotoPickerInteractorInput {
    
    weak var presenter: PhotoPickerInteractorOutput?

    func fetchPhotos() {
        let imageManager = PHImageManager.default()

        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat

        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        var images: [UIImage] = []
        fetchResult.objects(at: .init(integersIn: 0..<fetchResult.count)).forEach {
            let size = CGSize(width: 500, height: 500)
            imageManager.requestImage(for: $0, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                guard let image = image else { return }
                images.append(image)
            }
        }
        presenter?.interactor(self, didReceivePhotos: images)
    }
}
