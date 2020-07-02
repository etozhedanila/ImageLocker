//
//  FoldersViewController.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol FoldersViewInput: TableEditable {
    var presenter: FoldersViewOutput? { get set }
    var viewController: UIViewController { get }
    
}

class FoldersViewController: UIViewController, FoldersViewInput {
    var presenter: FoldersViewOutput?
    var viewController: UIViewController { return self }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        makeConstraints()
        presenter?.viewDidLoad(self)
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
