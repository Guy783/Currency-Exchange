//
//  CurrencyListViewController.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import os
import UIKit

class CurrencyListViewController: BaseViewController, BaseTableViewable {
    @IBOutlet var tableView: UITableView!
    var dataProvider: TableDataProviderable!
    
    private (set) var currencies: [Currency]!
    private (set) var currencyPairsHandler: CurrencyPairsHandler!
    
    // MARK: - View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(isHidden: true)
        setupTableView()
    }
    
    // MARK: - Setup Table
    private func setupTableView() {
        registerCells()
        setupDefaultTableData()
        setupTableView(with: dataProvider, delegate: dataProvider)
    }
    
    private func registerCells() {
        let currencyTableViewCellNib = UINib(nibName: CurrencyTableViewCell.className, bundle: .main)
        tableView.register(currencyTableViewCellNib, forCellReuseIdentifier: CurrencyTableViewCell.className)
    }
    
    // MARK: - Setup Table: BaseTableViewable
    func setupDefaultTableData() {
        let currencyListViewModel = CurrencyListViewModel(with: currencies, selectedCurrencies: currencyPairsHandler.selectedCurrencies)
        dataProvider = CurrencyListDataProvider(with: tableView, viewModel: currencyListViewModel, delegate: self)
        
        if currencies.isEmpty {
            refresh()
        }
    }
    
    // MARK: - Helper methods
    func update(with currencies: [Currency], and currencyPairsHandler: CurrencyPairsHandler) {
        self.currencies = currencies
        self.currencyPairsHandler = currencyPairsHandler
    }
    
    // MARK: - Reload Data
    func refresh() {
        Currency.fetchCurrencies { results, error in
            if error != nil {
                self.presentOkAlert(message: R.string.localised.errorGenericMessage())
            } else if let currencies = results as? [Currency] {
                self.currencies = currencies
                self.dataProvider.update(with: CurrencyListViewModel(with: self.currencies,
                                                                     selectedCurrencies: self.currencyPairsHandler.selectedCurrencies))
            }
        }
    }
}

// MARK: - DataProviderDelegate
extension CurrencyListViewController: DataProviderDelegate {
    func reloadData() {
        refresh()
    }
    
    func didSelect(_ field: Field) {
        guard let currency = Currency.fetchCurrency(with: field.detail, from: currencies) else {
            return
        }
        currencyPairsHandler.addSelectedCurrency(currency) { didAddCurrency, didAddNewCurrencyPair in
            DispatchQueue.main.async {
                if didAddNewCurrencyPair {
                    self.showCurrencyPairsViewController(with: self.currencyPairsHandler.selectedCurrencyPairs)
                } else {
                    if didAddCurrency == false {
                        self.presentOkAlert(message: R.string.localised.currenciesAlreadySelected(currency.name))
                    } else {
                        self.showCurrencyList()
                    }
                }
            }
        }
    }
}

// MARK: - Navigation
extension CurrencyListViewController {
    private func showCurrencyPairsViewController(with selectedCurrencyPairs: UserCurrencyPairs) {
        guard let coordinator = coordinator as? CurrencyListCoordinator else {
            return
        }
        coordinator.showCurrencyPairsViewController(with: currencies, selectedUserCurrencyPairs: selectedCurrencyPairs)
    }
    
    private func showCurrencyList() {
        guard let coordinator = coordinator as? CurrencyListCoordinator else {
            return
        }
        coordinator.showCurrencyListViewController(with: currencies, currencyPairsHandler: currencyPairsHandler)
    }
}
