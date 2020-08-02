//
//  BaseCollectionDataManager.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol CollectionConfigurable where Self: UICollectionViewCell {
    associatedtype CellModel
    func configure(model: CellModel)
}

protocol CollectionConfigurator {
    static var reuseId: String { get }
    var height: CGFloat { get set }
    var width: CGFloat { get set }
    func configure(cell: UICollectionViewCell)
}

class CollectionCellConfigurator<CellType: CollectionConfigurable, CellModel>: CollectionConfigurator where CellType.CellModel == CellModel {

    static var reuseId: String { return String(describing: CellType.self) }
    var model: CellModel
    var height: CGFloat
    var width: CGFloat

    init(model: CellModel, size: CGSize) {
        self.model = model
        self.height = size.height
        self.width = size.width
    }

    func configure(cell: UICollectionViewCell) {
        (cell as? CellType)?.configure(model: model)
    }
}

class BaseCollectionDataManager: NSObject, UICollectionViewDataSource {
    var items: [CollectionConfigurator] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item).reuseId, for: indexPath)
        item.configure(cell: cell)
        return cell
    }
}
