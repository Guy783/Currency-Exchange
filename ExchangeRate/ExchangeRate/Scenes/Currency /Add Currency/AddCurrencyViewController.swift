//
//  AddCurrencyViewController.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 07/03/2020.
//

import UIKit

class AddCurrencyViewController: BaseViewController {
    @IBOutlet private var addCurrencyButton: UIButton!
    @IBOutlet private var addCurrencyTitleButton: UIButton!
    @IBOutlet private var addCurrencyDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupNavigationBar(isHidden: true)
        setupSubviews()
    }
    
    // MARK: - Setup Subviews
    private func setupSubviews() {
        addCurrencyTitleButton.setTitle(R.string.localised.currenciesAdd(), for: .normal)
        addCurrencyDetailLabel.text = R.string.localised.currenciesChoose()
        makeAccessible()
    }
    
    override func makeAccessible() {
        addCurrencyButton.makeAccessible(accessibilityLabel: R.string.accessibility.currencyAdd(),
                                         accessibilityHint: R.string.accessibility.currencyAdd())
        addCurrencyTitleButton.makeAccessible(accessibilityLabel: R.string.accessibility.currencyAdd(),
                                              accessibilityHint: R.string.accessibility.currencyAdd())
        addCurrencyDetailLabel.makeAccessible(accessibilityLabel: R.string.accessibility.currencyAdd(),
                                              accessibilityHint: R.string.localised.currenciesChoose())
    }
    
    // MARK: - IBActions
    @IBAction private func didTouchUpInsideAddCurrencyButton(_ sender: Any) {
        showCurrencyList()
    }
    
    @IBAction private func didTouchUpInsideAddCurrencyTitleButton(_ sender: Any) {
        showCurrencyList()
    }
}

// MARK: - Navigation
extension AddCurrencyViewController {
    private func showCurrencyList() {
        guard let coordinator = coordinator as? CurrencyCoordinator else {
            return
        }
        let userCurrencyPairs = UserCurrencyPairs(selectedPairs: [])
        let currencyPairsHandler = CurrencyPairsHandler(selectedCurrencies: [], selectedCurrencyPairs: userCurrencyPairs)
        coordinator.showCurrencyListViewController(with: [], currencyPairsHandler: currencyPairsHandler)
    }
}
