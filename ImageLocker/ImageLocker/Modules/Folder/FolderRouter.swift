//
//  FolderRouter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 25.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation
import Photos

class FolderRouter: RouterInterface {
    
    let router: AppRouter

    init(router: AppRouter) {
        self.router = router
    }

    func preview(photos: [SavedPhotoCellModel], selectedPhotoIndex: Int) {
        let assembly = PhotoPreviewAssembly(photos: photos, selectedPhotoIndex: selectedPhotoIndex)
        let viewController = assembly.createPhotoPreview(appRouter: router).viewController
        viewController.modalPresentationStyle = .overFullScreen
        router.push(viewController: viewController, animated: true)
    }

    func openPhotoLibrary(imagesPicked: @escaping ([PhotoCellModel]) -> Void) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        if authorizationStatus == .authorized {
            DispatchQueue.main.async {
                self.presentPhotoLibrary(resultHandler: imagesPicked)
            }
        } else {
            requestAuth { [weak self] isSuccess in
                guard let self = self, isSuccess else { return }
                DispatchQueue.main.async {
                    self.presentPhotoLibrary(resultHandler: imagesPicked)
                }
            }
        }
    }

    private func requestAuth(completion: ((Bool) -> Void)?) {
        PHPhotoLibrary.requestAuthorization { (status) in
            guard status == .authorized else {
                completion?(false)
                return
            }
            completion?(true)
        }
    }

    private func presentPhotoLibrary(resultHandler: @escaping ([PhotoCellModel]) -> Void) {
        let viewController = PhotoPickerAssembly.createPhotoPicker(appRouter: router, resultHandler: resultHandler).viewController
        router.push(viewController: viewController, animated: true)
    }
}
