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
    
    func configure(title: String)
    func set(page: Int)
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
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var closeButton: UIBarButtonItem {
        return UIBarButtonItem(title: LocalizedString.close, style: .plain, target: self, action: #selector(closeDidTapped(sender:)))
    }
    
    private var defaultTintColor: UIColor?
    private var defaultBarTintColor: UIColor?
    private var defaultTitleTextAttributes: [NSAttributedString.Key : Any]?
    
    private enum LocalizedString {
        static let close = "Закрыть"
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetToDefaultNavigationBar()
    }
    
    func configure(title: String) {
        self.title = title
    }
    
    func set(page: Int) {
        let screenWidth = UIScreen.main.bounds.width
        collectionView.contentOffset = .init(x: screenWidth * CGFloat(page), y: 0)
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = closeButton
        defaultTintColor = navigationController?.navigationBar.tintColor
        defaultBarTintColor = navigationController?.navigationBar.barTintColor
        defaultTitleTextAttributes = navigationController?.navigationBar.titleTextAttributes
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func resetToDefaultNavigationBar() {
        navigationController?.navigationBar.barTintColor = defaultBarTintColor
        navigationController?.navigationBar.tintColor = defaultTintColor ?? .blue
        navigationController?.navigationBar.titleTextAttributes = defaultTitleTextAttributes
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func closeDidTapped(sender: UIBarButtonItem) {
        presenter?.viewDidTapClose(self)
    }
}
