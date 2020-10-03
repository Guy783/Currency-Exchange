//
//  Coordinator.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 07/03/2020.
//

import Foundation

class Coordinator: Coordinatorable {
    var childCoordinators: [Coordinatorable] = [Coordinatorable]()
    var router: Router
    weak var delegate: CoordinatorDelegate?
    
    required init(router: Router, coordinatorDelegate: CoordinatorDelegate?) {
        self.router = router
        self.delegate = coordinatorDelegate
    }
    
    func start() {}
}

extension Coordinator: CoordinatorDelegate {}
