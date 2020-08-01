//
//  FolderViewController.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 25.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol FolderViewInput: class {
    var viewController: UIViewController { get }
    var presenter: FolderViewOutput? { get set }
    
    func configure(title: String)
}

class FolderViewController: UIViewController, FolderViewInput {
    var viewController: UIViewController { return self }
    var presenter: FolderViewOutput?
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        return button
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
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
        
    }
    
    @objc private func addTapped(_ sender: UIBarButtonItem) {
        presenter?.viewDidTapAddImage(self)
    }
}
