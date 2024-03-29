//
//  FoldersListViewController.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol FoldersListViewInput: TableEditable {
    
    var presenter: FoldersListViewOutput? { get set }
    var viewController: UIViewController { get }
}

class FoldersListViewController: UIViewController, FoldersListViewInput {
    
    var presenter: FoldersListViewOutput?
    var viewController: UIViewController { return self }

    private enum LocalizedString {
        static let title = "Папки"
        static let edit = "Редактировать"
        static let done = "Готово"
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self.presenter?.dataManager
        tableView.delegate = self.presenter?.dataManager
        tableView.register(FolderCell.self, forCellReuseIdentifier: String(describing: FolderCell.self))
        return tableView
    }()

    private lazy var addFolderButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFolderTapped(_:)))
        return button
    }()

    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: LocalizedString.edit, style: .plain, target: self, action: #selector(editTapped(_:)))
        return button
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedString.title
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = addFolderButton
        navigationItem.leftBarButtonItem = editButton
        makeConstraints()
        presenter?.viewDidLoad(self)
    }

    @objc private func addFolderTapped(_ sender: UIBarButtonItem) {
        presenter?.viewDidTapCreateFolder(self)
    }

    @objc private func editTapped(_ sender: UIBarButtonItem) {
        let isEditing = tableView.isEditing
        tableView.setEditing(!isEditing, animated: true)
        let title = isEditing ? LocalizedString.edit : LocalizedString.done
        navigationItem.leftBarButtonItem?.title = title
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
