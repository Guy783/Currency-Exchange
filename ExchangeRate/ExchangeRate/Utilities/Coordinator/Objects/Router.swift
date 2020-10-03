//
//  Router.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 07/03/2020.
//

import UIKit

final class Router: Routerable {
    private(set) var rootController: UINavigationController
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    func setRootViewController(viewController: UIViewController, hideBar: Bool = false, animated: Bool = true) {
        rootController.setViewControllers([viewController], animated: animated)
        rootController.setNavigationBarHidden(hideBar, animated: animated)
    }
    
    func pushViewController(viewController: UIViewController, animated: Bool = true) {
        rootController.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(animated: Bool = true) {
        rootController.popViewController(animated: animated)
    }
    
    func presentViewController(viewController: UIViewController, animated: Bool = true) {
        rootController.present(viewController, animated: animated, completion: nil)
    }
    
    func dismissViewController(animated: Bool = true) {
        rootController.dismiss(animated: animated, completion: nil)
    }
}
