//
//  FolderViewController.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 25.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol FolderViewInput: AnyObject, CollectionEditable, Loadable {
    
    var viewController: UIViewController { get }
    var presenter: FolderViewOutput? { get set }

    func configure(title: String)
}

class FolderViewController: UIViewController, FolderViewInput {
    
    var viewController: UIViewController { return self }
    var presenter: FolderViewOutput?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = presenter?.dataManager
        collectionView.delegate = presenter?.dataManager
        collectionView.register(SavedPhotoCell.self, forCellWithReuseIdentifier: String(describing: SavedPhotoCell.self))
        return collectionView
    }()
    
    var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.isHidden = true
        return view
    }()

    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        return button
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(loader)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = addButton
        makeConstraints()
        presenter?.viewDidLoad(self)
    }

    func configure(title: String) {
        self.title = title
    }

    private func makeConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        loader.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc private func addTapped(_ sender: UIBarButtonItem) {
        presenter?.viewDidTapAddImage(self)
    }
}
