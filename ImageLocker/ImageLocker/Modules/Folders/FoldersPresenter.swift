//
//  FoldersPresenter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import Foundation

protocol FoldersViewOutput: class {
    var view: FoldersViewInput? { get set }
    
    func viewDidLoad(_ view: FoldersViewInput)
}

class FoldersPresenter: FoldersViewOutput {
    weak var view: FoldersViewInput?
    var interactor: FoldersInteractorInput?
    private let router: FoldersRouter
    
    
    init(router: FoldersRouter) {
        self.router = router
    }
    
    func viewDidLoad(_ view: FoldersViewInput) {
        
    }
}

extension FoldersPresenter: FoldersInteractorOutput {
    
}
