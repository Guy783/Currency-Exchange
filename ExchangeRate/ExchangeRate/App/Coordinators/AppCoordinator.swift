//
//  AppMainCoordinator.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 07/03/2020.
//

import UIKit

class AppCoordinator: Coordinator {
    override func start() {
        runCurrencyCoordinator()
    }
    
    private func runCurrencyCoordinator() {
        let coordinator = CurrencyCoordinator(router: router, coordinatorDelegate: self)
        addChildCoordinator(coordinator: coordinator)
        coordinator.start()
    }
}
