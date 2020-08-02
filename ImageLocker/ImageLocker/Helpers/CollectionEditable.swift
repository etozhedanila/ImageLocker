//
//  CollectionEditable.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol CollectionEditable {
    var collectionView: UICollectionView { get }
}

extension CollectionEditable {
    func reload() {
        collectionView.reloadData()
    }

}
