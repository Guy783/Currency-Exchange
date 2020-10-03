//
//  UserCurrencyPairs.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 15/03/2020.
//

import Foundation

struct UserCurrencyPairs {
    private(set) var selectedPairs: [String]
    
    mutating func addNewCurrencyPair(with currencyOne: Currency, currencyTwo: Currency) {
        let currencyPair = "\(currencyOne.code)\(currencyTwo.code)"
        if selectedPairs.contains(currencyPair) == false {
            selectedPairs.insert(currencyPair, at: 0)
        }
    }
    
    mutating func removeCurrencyPair(_ currencyPair: String) {
        if let index = selectedPairs.firstIndex(of: currencyPair) {
            selectedPairs.remove(at: index)
        }
    }
}

// MARK: - Helper Methods
extension UserCurrencyPairs {
    func fetchUrlSuffix() -> String {
        var suffix = "?"
        let selectedCurrencyPairsCount = selectedPairs.count
        for (index, selectedCurrencyPair) in selectedPairs.enumerated() {
            if index == selectedCurrencyPairsCount - 1 {
                suffix.append("pairs=\(selectedCurrencyPair)")
            } else {
                suffix.append("pairs=\(selectedCurrencyPair)&")
            }
        }
        return suffix
    }
}

// MARK: - Fetch & Save Currency Pair
extension UserCurrencyPairs {
    func saveSelectedPairs() {
        let defaults = UserDefaults.standard
        defaults.set(selectedPairs, forKey: "UserCurrencyPairs")
    }
    
    static func fetchSavedSelectedCurrencyPairs() -> [String] {
        let defaults = UserDefaults.standard
        return defaults.stringArray(forKey: "UserCurrencyPairs") ?? [String]()
    }
}
