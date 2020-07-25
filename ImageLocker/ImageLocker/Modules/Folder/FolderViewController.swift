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
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeConstraints()
        presenter?.viewDidLoad(self)
    }
    
    func configure(title: String) {
        DispatchQueue.main.async {
            
            self.title = title
        }
    }
    
    private func makeConstraints() {
        
    }
}
