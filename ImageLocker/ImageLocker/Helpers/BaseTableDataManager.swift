//
//  BaseTableDataManager.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol ConfigurableCell where Self: UITableViewCell {
    associatedtype CellModel
    func configure(model: CellModel)
}

protocol CellConfigurator {
    static var reuseId: String { get }
    var height: CGFloat { get set }
    func configure(cell: UITableViewCell)
}

class TableCellConfigurator<CellType: ConfigurableCell, CellModel>: CellConfigurator where CellType.CellModel == CellModel {
    
    static var reuseId: String { return String(describing: CellType.self) }
    var model: CellModel
    var height: CGFloat
    
    init(model: CellModel, height: CGFloat) {
        self.model = model
        self.height = height
    }
    
    func configure(cell: UITableViewCell) {
        (cell as? CellType)?.configure(model: model)
    }
}

class BaseTableDataManager: NSObject, UITableViewDataSource {
    var items: [CellConfigurator] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
        item.configure(cell: cell)
        
        return cell
    }
}
