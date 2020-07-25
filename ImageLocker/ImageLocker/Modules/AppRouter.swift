//
//  AppRouter.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 29.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol RouterInterface {
    var router: AppRouter { get }
}

protocol RouteFolders where Self: RouterInterface { }

extension RouteFolders {
    func showFolders() {
        let vc = FoldersListAssembly.createFolders(appRouter: router).viewController
        router.push(viewController: vc, animated: true)
    }
}

class AppRouter {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(viewController: UIViewController, animated: Bool, transition: CATransition? = nil) {
        if let transition = transition {
            navigationController.view.layer.add(transition, forKey: kCATransition)
        }
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool, transition: CATransition? = nil) {
        if let transition = transition {
            navigationController.view.layer.add(transition, forKey: kCATransition)
        }
        navigationController.popViewController(animated: animated)
    }
    
    func popToRootViewController(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
}
