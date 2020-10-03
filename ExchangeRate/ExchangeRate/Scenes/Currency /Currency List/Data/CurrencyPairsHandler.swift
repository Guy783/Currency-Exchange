//
//  CurrencyPairsHandler.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 15/03/2020.
//

import Foundation

struct CurrencyPairsHandler {
    private (set) var selectedCurrencies: [Currency]
    private (set) var selectedCurrencyPairs: UserCurrencyPairs
}

// MARK: - Mutating Functions
extension CurrencyPairsHandler {
    mutating func addSelectedCurrency(_ currency: Currency, completion: (_ didAddCurrency: Bool, _ didAddNewCurrencyPair: Bool) -> Void) {
        guard selectedCurrencies.contains(where: { $0.id == currency.id }) == false else {
            return completion(false, false)
        }
        selectedCurrencies.append(currency)
        if selectedCurrencies.count == 2 {
            // Add a new currency
            selectedCurrencyPairs.addNewCurrencyPair(with: selectedCurrencies[0], currencyTwo: selectedCurrencies[1])
            // SelectedCurrencies can only have two Currencies, so reset after two Currencies are added
            selectedCurrencies.removeAll()
            completion(true, true)
        } else {
            completion(true, false)
        }
    }
}
