//
//  PhotoPickerDataManager.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol PhotoPickerDataManagerDelegate: class {
    func dataManager(_ dataManager: PhotoPickerDataManager, didSelectPhotoAt index: Int)
}

class PhotoPickerDataManager: BaseCollectionDataManager {
    weak var delegate: PhotoPickerDataManagerDelegate?
}

extension PhotoPickerDataManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.dataManager(self, didSelectPhotoAt: indexPath.row)
    }
}

extension PhotoPickerDataManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.row]
        let size = CGSize(width: item.width, height: item.height)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
