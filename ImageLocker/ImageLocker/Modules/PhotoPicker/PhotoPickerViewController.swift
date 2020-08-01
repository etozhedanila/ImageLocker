//
//  PhotoPickerViewController.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol PhotoPickerViewInput: class {
    var viewController: UIViewController { get }
    var presenter: PhotoPickerViewOutput? { get set }
}

class PhotoPickerViewController: UIViewController, PhotoPickerViewInput {
    var viewController: UIViewController { return self }
    var presenter: PhotoPickerViewOutput?
    
    lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = presenter?.dataManager
        collectionView.delegate = presenter?.dataManager
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: String(describing: PhotosCell.self))
        return collectionView
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(photosCollectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeConstraints()
        presenter?.viewDidLoad(self)
    }
    
    private func makeConstraints() {
        photosCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
