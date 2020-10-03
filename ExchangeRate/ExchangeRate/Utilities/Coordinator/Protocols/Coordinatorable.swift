//
//  Coordinatorable.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 17/03/2020.
//

import Foundation

protocol Coordinatorable: class {
    var router: Router { get set }
    var childCoordinators: [Coordinatorable] { get set }
    var delegate: CoordinatorDelegate? { get set }
    
    init(router: Router, coordinatorDelegate: CoordinatorDelegate?)
    
    func start()
    func addChildCoordinator(coordinator: Coordinatorable)
    func removeChildCoordinator(coordinator: Coordinatorable)
}

extension Coordinatorable {
    func addChildCoordinator(coordinator: Coordinatorable) {
        if childCoordinators.contains(where: { $0 === coordinator }) == false {
            childCoordinators.append(coordinator)
        }
    }
    
    func removeChildCoordinator(coordinator: Coordinatorable) {
        guard childCoordinators.isEmpty == false else {
            return
        }
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
