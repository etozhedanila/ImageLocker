//
//  CreatePasswordViewController.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol CreatePasswordViewInput: class {
    var presenter: CreatePasswordViewOutput? { get set }
    var viewController: UIViewController { get }
}

class CreatePasswordViewController: UIViewController, CreatePasswordViewInput {
    var presenter: CreatePasswordViewOutput?
    var viewController: UIViewController { return self }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeConstraints()
        presenter?.viewDidLoad(self)
    }
    
    private func makeConstraints() {
    
    }
    
}
