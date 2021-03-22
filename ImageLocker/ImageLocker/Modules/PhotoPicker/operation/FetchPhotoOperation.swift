//
//  FetchPhotoOperation.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 23.03.2021.
//  Copyright © 2021 Виталий Субботин. All rights reserved.
//

import UIKit
import Photos

class FetchPhotoOperation: Operation {
    
    private let asset: PHAsset
    private let size: CGSize
    private let completion: ((UIImage?) -> Void)?
    
    init(asset: PHAsset, size: CGSize, completion: ((UIImage?) -> Void)?) {
        self.asset = asset
        self.size = size
        self.completion = completion
    }
    
    override func main() {
        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        imageManager.requestImage(
            for: asset,
            targetSize: size,
            contentMode: .aspectFill,
            options: requestOptions,
            resultHandler: { (image, _) in
                self.completion?(image)
            })
    }
}
