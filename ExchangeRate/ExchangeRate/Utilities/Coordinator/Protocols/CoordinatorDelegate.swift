//
//  CoordinatorDelegate.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 17/03/2020.
//

import UIKit

protocol CoordinatorDelegate: class {
    func dismissTopViewController(animated: Bool)
    func showFromParentViewController(_ viewController: UIViewController, isPushed: Bool, animated: Bool)
    func didFinishWithChildCoordinator(coordinator: Coordinatorable)
}

extension CoordinatorDelegate where Self: Coordinatorable {
    func dismissTopViewController(animated: Bool) {
        router.dismissViewController(animated: animated)
    }
    
    func didFinishWithChildCoordinator(coordinator: Coordinatorable) {
        removeChildCoordinator(coordinator: coordinator)
    }
    
    func showFromParentViewController(_ viewController: UIViewController, isPushed: Bool, animated: Bool) {
        if isPushed {
            router.pushViewController(viewController: viewController, animated: animated)
        } else {
            router.presentViewController(viewController: viewController, animated: animated)
        }
    }
}
