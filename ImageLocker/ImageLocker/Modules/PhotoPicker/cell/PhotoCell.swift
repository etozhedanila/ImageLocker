//
//  PhotosCell.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit
import Photos

struct PhotoCellModel {
    var asset: PHAsset
    var isSelected: Bool = false
    
    var id: String {
        return asset.localIdentifier
    }
    
    init(asset: PHAsset) {
        self.asset = asset
    }
}

class PhotoCellConfigurator: CollectionCellConfigurator<PhotoCell, PhotoCellModel> {
    
    init(model: PhotoCellModel) {
        let width = (UIScreen.main.bounds.width - (3 * 3)) / 4
        let size = CGSize(width: width, height: width)
        super.init(model: model, size: size)
    }
}

class PhotoCell: UICollectionViewCell {
    
    private let photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        return photoView
    }()

    private let overlayView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        return view
    }()

    private var imageRequestID: PHImageRequestID?
    private var photoAsset: PHAsset?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoView)
        contentView.addSubview(overlayView)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
        
        guard let imageRequestID = imageRequestID else { return }
        PhotosCacheManager.shared.imageManager.cancelImageRequest(imageRequestID)
        self.imageRequestID = nil
    }

    private func makeConstraints() {
        photoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - CollectionConfigurable
extension PhotoCell: CollectionConfigurable {
    
    func configure(model: PhotoCellModel) {
        self.photoAsset = model.asset
        loadPhoto(asset:  model.asset)
        self.overlayView.isHidden = !model.isSelected
    }
    
    private func loadPhoto(asset: PHAsset) {
        DispatchQueue.global(qos: .userInitiated).async {
                let size = CGSize(width: 200, height: 200)
                self.imageRequestID = PhotosCacheManager.shared.imageManager.requestImage(
                    for: asset,
                    targetSize: size,
                    contentMode: .aspectFill,
                    options: PhotosCacheManager.shared.requestOptions,
                    resultHandler: { [weak self] (image, _) in
                        guard let self = self, let image = image, self.photoAsset == asset else { return }
                        DispatchQueue.main.async {
                            self.photoView.image = image
                        }
                        self.imageRequestID = nil
                    })
        }
    }
}

extension PhotoCell {
    func update(isSelected: Bool) {
        self.overlayView.isHidden = !isSelected
    }
}
