//
//  PhotoPickerPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol PhotoPickerViewOutput: class {
    var view: PhotoPickerViewInput? { get set }
    var dataManager: PhotoPickerDataManager { get }
    
    func viewDidLoad(_ view: PhotoPickerViewInput)
}

class PhotoPickerPresenter: PhotoPickerViewOutput {
    weak var view: PhotoPickerViewInput?
    var dataManager: PhotoPickerDataManager
    private let router: PhotoPickerRouter
    
    init(dataManager: PhotoPickerDataManager, router: PhotoPickerRouter) {
        self.dataManager = dataManager
        self.router = router
    }
    
    func viewDidLoad(_ view: PhotoPickerViewInput) {
        
    }
}

extension PhotoPickerPresenter: PhotoPickerDataManagerDelegate {
    func dataManager(_ dataManager: PhotoPickerDataManager, didSelectPhotoAt indexPath: IndexPath) {
        
    }
}
