//
//  SavedPhotoCell.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 23.03.2021.
//  Copyright © 2021 Виталий Субботин. All rights reserved.
//

import UIKit

struct SavedPhotoCellModel {
    let url: URL
}

class SavedPhotoCellConfigurator: CollectionCellConfigurator<SavedPhotoCell, SavedPhotoCellModel> {
    
    init(model: SavedPhotoCellModel) {
        let width = (UIScreen.main.bounds.width - (3 * 3)) / 4
        let size = CGSize(width: width, height: width)
        super.init(model: model, size: size)
    }
}

class SavedPhotoCell: UICollectionViewCell {
    
    private let photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        return photoView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoView)
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
    }
}

// MARK: - CollectionConfigurable
extension SavedPhotoCell: CollectionConfigurable {
    
    func configure(model: SavedPhotoCellModel) {
        self.photoView.image = UIImage(contentsOfFile: model.url.path)
    }
}
