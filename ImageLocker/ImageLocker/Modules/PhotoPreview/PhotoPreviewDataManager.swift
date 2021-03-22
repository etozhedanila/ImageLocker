//
//  PhotoPreviewDataManager.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol PhotoPreviewDataManagerDelegate: class {
    
    func dataManager(_ dataManager: PhotoPreviewDataManager, didScrollToItemAtIndex index: Int)
}

class PhotoPreviewDataManager: BaseCollectionDataManager {
    
    weak var delegate: PhotoPreviewDataManagerDelegate?
}

extension PhotoPreviewDataManager: UICollectionViewDelegate {
    
}

extension PhotoPreviewDataManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.row]
        let size = CGSize(width: item.width, height: item.height)
        return size
    }
}
