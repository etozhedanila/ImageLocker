//
//  PhotosCacheManager.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 23.03.2021.
//  Copyright © 2021 Виталий Субботин. All rights reserved.
//

import Photos

class PhotosCacheManager {
    
    let imageManager = PHCachingImageManager()
    
    let requestOptions: PHImageRequestOptions = {
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .fastFormat
        
        return requestOptions
    }()
    
    static let shared = PhotosCacheManager()
    
    private init() { }
    
    func startCaching(assets: [PHAsset]) {
        let size = CGSize(width: 200, height: 200)
        imageManager.startCachingImages(for: assets, targetSize: size, contentMode: .aspectFill, options: requestOptions)
    }
}
