//
//  CurrencyPairsUpdater.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 18/03/2020.
//

import UIKit

protocol CurrencyPairsUpdaterDelegate: class {
    func didReturnNewCurrencyPairs(_ currencyPairs: [CurrencyPair])
    func didReturnFailToReloadCurrencyPairs(with errorMessage: String)
}

class CurrencyPairsUpdater {
    private (set) var currencyPairs: String
    private (set) var timer: Timer?
    private (set) weak var delegate: CurrencyPairsUpdaterDelegate?
    
    init(currencyPairs: String, delegate: CurrencyPairsUpdaterDelegate) {
        self.currencyPairs = currencyPairs
        self.delegate = delegate
    }
}

// MARK: - Timer Methods
extension CurrencyPairsUpdater {
    @objc
    private func runReloadCurrencyPairs() {
        reloadCurrencyPairs(with: currencyPairs)
    }
    
    private func reloadCurrencyPairs(with currencyPairs: String) {
        Currency.fetchCurrenciesPairs(with: currencyPairs) { results, error in
            if let currencyPairs = results as? [CurrencyPair], error == nil, self.timerIsValid() {
                self.delegate?.didReturnNewCurrencyPairs(currencyPairs)
            } else {
                self.stopTimer()
                self.delegate?.didReturnFailToReloadCurrencyPairs(with: R.string.localised.errorGenericMessage())
            }
        }
    }
}

// MARK: - Public Methods
extension CurrencyPairsUpdater {
    func runTimer(with newCurrencyPairs: String) {
        self.currencyPairs = newCurrencyPairs
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(runReloadCurrencyPairs),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    func stopTimer() {
        if timerIsValid() {
            timer?.invalidate()
        }
        timer = nil
    }
    
    func timerIsValid() -> Bool {
        guard let currencyPairsUpdaterTimer = timer, currencyPairsUpdaterTimer.isValid else {
            return false
        }
        return true
    }
}
