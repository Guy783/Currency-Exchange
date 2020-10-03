//
//  CurrencyPairsListTableViewController.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 14/03/2020.

//

import UIKit

class CurrencyPairsListTableViewController: BaseViewController, BaseTableViewable {
    @IBOutlet var tableView: UITableView!
    var dataProvider: TableDataProviderable!
    
    private (set) var currencies: [Currency]!
    private (set) var selectedUserCurrencyPairs: UserCurrencyPairs!
    private (set) var currencyPairsUpdater: CurrencyPairsUpdater!
    
    // MARK: - View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(isHidden: true)
        setupTableView()
        refresh()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        currencyPairsUpdater.stopTimer()
    }
    
    // MARK: - Setup Table
    private func setupTableView() {
        registerCells()
        setupDefaultTableData()
        setupTableView(with: dataProvider, delegate: dataProvider)
    }
    
    private func registerCells() {
        let currencyTableViewCellNib = UINib(nibName: CurrencyPairsTableViewCell.className, bundle: .main)
        tableView.register(currencyTableViewCellNib, forCellReuseIdentifier: CurrencyPairsTableViewCell.className)
        
        let addItemTableViewCellNib = UINib(nibName: AddItemTableViewCell.className, bundle: .main)
        tableView.register(addItemTableViewCellNib, forCellReuseIdentifier: AddItemTableViewCell.className)
    }
    
    // MARK: - Setup Table: BaseTableViewable
    func setupDefaultTableData() {
        let currencyListViewModel = CurrencyPairsListViewModel(with: [], and: currencies, with: selectedUserCurrencyPairs.selectedPairs)
        dataProvider = CurrencyPairsListDataProvider(with: tableView,
                                                     viewModel: currencyListViewModel,
                                                     delegate: self)
    }
    
    // MARK: - Helper methods
    func update(with currencies: [Currency], and selectedUserCurrencyPairs: UserCurrencyPairs) {
        self.currencies = currencies
        self.selectedUserCurrencyPairs = selectedUserCurrencyPairs
    }
    
    // MARK: - Refresh
    func refresh() {
        if currencyPairsUpdater == nil {
            currencyPairsUpdater = CurrencyPairsUpdater(currencyPairs: selectedUserCurrencyPairs.fetchUrlSuffix(), delegate: self)
        }
        currencyPairsUpdater.runTimer(with: selectedUserCurrencyPairs.fetchUrlSuffix())
    }
    
    func updateDataProvider(with newCurrencyPairs: [CurrencyPair], with currencyPairsInSelectedOrder: [String]) {
        DispatchQueue.main.async {
            guard let currencyPairsDataProvider = self.dataProvider as? CurrencyPairsListDataProvider else {
                return
            }
            let updatedViewModel = CurrencyPairsListViewModel(with: newCurrencyPairs, and: self.currencies, with: self.selectedUserCurrencyPairs.selectedPairs)
            currencyPairsDataProvider.updateViewModel(with: updatedViewModel)
        }
    }
}

extension CurrencyPairsListTableViewController: CurrencyPairsUpdaterDelegate {
    func didReturnFailToReloadCurrencyPairs(with errorMessage: String) {
        self.presentOkAlert(message: errorMessage)
    }
    
    func didReturnNewCurrencyPairs(_ currencyPairs: [CurrencyPair]) {
        updateDataProvider(with: currencyPairs, with: selectedUserCurrencyPairs.selectedPairs)
    }
}

// MARK: - DataProviderDelegate
extension CurrencyPairsListTableViewController: DataProviderDelegate {
    func reloadData() {
        refresh()
    }
    
    func didSelect(_ field: Field) {
        if let field = field as? AddItemFieldViewModel, field.itemToAddFieldType == .currencyPair {
            guard let currencyCoordinator = coordinator as? CurrencyCoordinator else {
                return
            }
            
            currencyPairsUpdater.stopTimer()
            
            let currencyPairsHandler = CurrencyPairsHandler(selectedCurrencies: [], selectedCurrencyPairs: selectedUserCurrencyPairs)
            currencyCoordinator.showCurrencyListViewController(with: currencies,
                                                               currencyPairsHandler: currencyPairsHandler,
                                                               isPushed: false)
        }
    }
}
