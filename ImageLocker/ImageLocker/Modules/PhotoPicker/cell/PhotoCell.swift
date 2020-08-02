//
//  PhotosCell.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

struct PhotoCellModel {
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
    private let photoView: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()

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

    override var isSelected: Bool {
        didSet {
            overlayView.isHidden.toggle()
        }
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
        self.overlayView.isHidden = !isSelected
    }
}
