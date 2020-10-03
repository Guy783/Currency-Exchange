//
//  CurrencyCoordinator.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 07/03/2020.
//

import UIKit

protocol CurrencyCoordinatorDelegate: class {
    func goToCurrencyPairsView(with currencies: [Currency], selectedUserCurrencyPairs: UserCurrencyPairs)
}

class CurrencyCoordinator: Coordinator {
    override func start() {
        showAddCurrencyViewController()
    }
    
    func showAddCurrencyViewController() {
        let addCurrencyViewController = AddCurrencyViewController.instantiate(with: "AddCurrency")
        addCurrencyViewController.coordinator = self
        router.setRootViewController(viewController: addCurrencyViewController, hideBar: true, animated: true)
    }
    
    func showCurrencyListViewController(with currencies: [Currency], currencyPairsHandler: CurrencyPairsHandler, isPushed: Bool = false) {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen
        let newRouter = Router(rootController: navigationController)
        
        let currencyListCoordinator = CurrencyListCoordinator(router: newRouter, coordinatorDelegate: self)
        currencyListCoordinator.currencyCoordinatorDelegate = self
        currencyListCoordinator.start(with: currencies, currencyPairsHandler: currencyPairsHandler)
    }
    
    func showCurrencyPairsViewController(with currencies: [Currency], selectedUserCurrencyPairs: UserCurrencyPairs) {
        let currencyPairsListTableViewController = CurrencyPairsListTableViewController.instantiate(with: "CurrencyPairsList")
        currencyPairsListTableViewController.coordinator = self
        currencyPairsListTableViewController.update(with: currencies, and: selectedUserCurrencyPairs)
        router.pushViewController(viewController: currencyPairsListTableViewController, animated: true)
    }
}

extension CurrencyCoordinator: CurrencyCoordinatorDelegate {
    func goToCurrencyPairsView(with currencies: [Currency], selectedUserCurrencyPairs: UserCurrencyPairs) {
        if let currencyPairsListTableViewController = router.rootController.viewControllers.last as? CurrencyPairsListTableViewController {
            currencyPairsListTableViewController.update(with: currencies, and: selectedUserCurrencyPairs)
            currencyPairsListTableViewController.refresh()
        } else {
            showCurrencyPairsViewController(with: currencies, selectedUserCurrencyPairs: selectedUserCurrencyPairs)
        }
    }
}
