//
//  PhotosCell.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

struct PhotosCellModel { }



class PhotosCell: UICollectionViewCell {
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        photoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//extension PhotosCell {
//    
//}
