//
//  EnterPincodeViewController.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 29.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol EnterPincodeViewInput: class {
    var viewController: UIViewController { get }
    var presenter: EnterPincodeViewOutput? { get set }
}

class EnterPincodeViewController: UIViewController, EnterPincodeViewInput {
    var viewController: UIViewController { return self }
    var presenter: EnterPincodeViewOutput?
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .cyan
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    private func makeConstraints() {
        
    }
}
