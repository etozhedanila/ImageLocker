//
//  PhotosCell.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

struct PhotoCellModel {
    
    init(image: UIImage?, isSelected: Bool = false) {
        self.image = image
        self.isSelected = isSelected
    }
    
    init(url: URL) {
        print(url.path)
        image = UIImage(contentsOfFile: url.path)
    }
    
    var image: UIImage?
    var isSelected: Bool = false
}

class PhotoCellConfigurator: CollectionCellConfigurator<PhotoCell, PhotoCellModel> {
    
    init(model: PhotoCellModel) {
        let width = UIScreen.main.bounds.width / 4
        let size = CGSize(width: width, height: width)
        super.init(model: model, size: size)
    }
}

class PhotoCell: UICollectionViewCell {
    
    private let photoView = UIImageView()

    private let overlayView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        return view
    }()

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

extension PhotoCell: CollectionConfigurable {
    
    func configure(model: PhotoCellModel) {
        self.photoView.image = model.image
        self.overlayView.isHidden = !model.isSelected
    }
}

extension PhotoCell {
    func update(model: PhotoCellModel) {
        self.overlayView.isHidden = !model.isSelected
    }
}
