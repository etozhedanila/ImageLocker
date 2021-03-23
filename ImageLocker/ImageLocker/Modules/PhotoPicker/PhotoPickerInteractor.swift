//
//  PhotoPickerInteractor.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Photos

protocol PhotoPickerInteractorInput: class {
    var presenter: PhotoPickerInteractorOutput? { get set }
    func fetchAssets()
}

protocol PhotoPickerInteractorOutput: class {
    func interactor(_ interactor: PhotoPickerInteractorInput, didReceiveAssets assets: [PHAsset])
}

class PhotoPickerInteractor: PhotoPickerInteractorInput {
    
    weak var presenter: PhotoPickerInteractorOutput?
    
    func fetchAssets() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        guard fetchResult.count > 0 else {
            presenter?.interactor(self, didReceiveAssets: [])
            return
        }
        var assets: [PHAsset] = []
        let indexes = IndexSet(integersIn: 0..<fetchResult.count)
        fetchResult.objects(at: indexes).enumerated().forEach { (index, asset) in
            assets.append(asset)
        }
        presenter?.interactor(self, didReceiveAssets: assets)
    }
}
