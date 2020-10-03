//
//  CurrencyListCoordinator.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 15/03/2020.
//

import UIKit

class CurrencyListCoordinator: Coordinator {
    weak var currencyCoordinatorDelegate: CurrencyCoordinatorDelegate?
    
    func start(with currencies: [Currency], currencyPairsHandler: CurrencyPairsHandler) {
        let currencyListViewController = CurrencyListViewController.instantiate(with: "CurrencyList")
        currencyListViewController.coordinator = self
        currencyListViewController.update(with: currencies, and: currencyPairsHandler)
        router.setRootViewController(viewController: currencyListViewController)
        delegate?.showFromParentViewController(router.rootController, isPushed: false, animated: true)
    }
    
    func showCurrencyListViewController(with currencies: [Currency], currencyPairsHandler: CurrencyPairsHandler) {
        let currencyListViewController = CurrencyListViewController.instantiate(with: "CurrencyList")
        currencyListViewController.coordinator = self
        currencyListViewController.update(with: currencies, and: currencyPairsHandler)
        router.pushViewController(viewController: currencyListViewController)
    }
    
    func showCurrencyPairsViewController(with currencies: [Currency], selectedUserCurrencyPairs: UserCurrencyPairs) {
        delegate?.dismissTopViewController(animated: true)
        currencyCoordinatorDelegate?.goToCurrencyPairsView(with: currencies, selectedUserCurrencyPairs: selectedUserCurrencyPairs)
        delegate?.didFinishWithChildCoordinator(coordinator: self)
    }
}
