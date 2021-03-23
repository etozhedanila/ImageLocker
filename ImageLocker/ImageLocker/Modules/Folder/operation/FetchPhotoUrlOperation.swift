//
//  FetchPhotoUrlOperation.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 24.03.2021.
//  Copyright © 2021 Виталий Субботин. All rights reserved.
//

import Photos

class FetchPhotoUrlOperation: AsyncOperation {
    private let asset: PHAsset
    private let completion: ((URL?) -> Void)?
    private var requestID: PHContentEditingInputRequestID?
    
    init(asset: PHAsset, completion: ((URL?) -> Void)?) {
        self.asset = asset
        self.completion = completion
    }
    
    override func main() {
        requestID = asset.requestContentEditingInput(with: PHContentEditingInputRequestOptions()) { [weak self] (input, _) in
            guard let self = self, !self.isCancelled else { return }
            defer { self.state = .finished }
            let url = input?.fullSizeImageURL
            self.completion?(url)
        }
    }
    
    override func cancel() {
        super.cancel()
        guard let requestID = requestID else { return }
        asset.cancelContentEditingInputRequest(requestID)
    }
}
