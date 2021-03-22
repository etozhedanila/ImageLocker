//
//  Loadable.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 22.03.2021.
//  Copyright © 2021 Виталий Субботин. All rights reserved.
//

import UIKit

protocol Loadable {
    
    var loader: UIActivityIndicatorView { get set }
    
    func showLoading()
    func stopLoading()
}

extension Loadable {
    
    func showLoading() {
        loader.isHidden = false
        loader.startAnimating()
    }
    
    func stopLoading() {
        loader.stopAnimating()
        loader.isHidden = true
    }
}
