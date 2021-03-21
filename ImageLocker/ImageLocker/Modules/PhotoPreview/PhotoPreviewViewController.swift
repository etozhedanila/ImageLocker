//
//  PhotoPreviewViewController.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol PhotoPreviewViewInput: class, CollectionEditable {
    
    var viewController: UIViewController { get }
    var presenter: PhotoPreviewViewOutput? { get set }
}

class PhotoPreviewViewController: UIViewController, PhotoPreviewViewInput {
    
    var viewController: UIViewController { return self }
    var presenter: PhotoPreviewViewOutput?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self.presenter?.dataManager
        collectionView.dataSource = self.presenter?.dataManager
        collectionView.isPagingEnabled = true
        collectionView.register(ImagePreviewCell.self, forCellWithReuseIdentifier: String(describing: ImagePreviewCell.self))
        return collectionView
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
        view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        presenter?.viewDidLoad(self)
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
