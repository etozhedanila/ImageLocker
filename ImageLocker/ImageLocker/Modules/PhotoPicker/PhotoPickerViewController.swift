//
//  PhotoPickerViewController.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 01.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol PhotoPickerViewInput: class, CollectionEditable, Loadable {
    
    var viewController: UIViewController { get }
    var presenter: PhotoPickerViewOutput? { get set }

    func enableDoneButton(_ isEnabled: Bool)
    func updateCell(at index: Int, isSelected: Bool)
}

class PhotoPickerViewController: UIViewController, PhotoPickerViewInput {
    
    var viewController: UIViewController { return self }
    var presenter: PhotoPickerViewOutput?
    
    var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .white)
        loader.isHidden = true
        return loader
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = presenter?.dataManager
        collectionView.delegate = presenter?.dataManager
        collectionView.backgroundColor = .black
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: String(describing: PhotoCell.self))
        return collectionView
    }()

    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: LocalizedString.done, style: .plain, target: self, action: #selector(doneTapped(_:)))
        return button
    }()

    private enum LocalizedString {
        static let title = "Выберите фото"
        static let done = "Готово"
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(loader)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedString.title
        navigationItem.rightBarButtonItem = doneButton
        makeConstraints()
        presenter?.viewDidLoad(self)
    }

    func enableDoneButton(_ isEnabled: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = isEnabled
        navigationItem.rightBarButtonItem?.title = isEnabled ? LocalizedString.done : ""
    }
    
    func updateCell(at index: Int, isSelected: Bool) {
        let cell = collectionView.cellForItem(at: .init(item: index, section: 0))
        (cell as? PhotoCell)?.update(isSelected: isSelected)
    }

    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        loader.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc private func doneTapped(_ sender: UIBarButtonItem) {
        presenter?.viewDidEndPicking(self)
    }
}
