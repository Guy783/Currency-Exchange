//
//  CurrencyPair.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 14/03/2020.
//

import UIKit

typealias CurrencyPairAndRate = (currenyCodes: String, exchangeRate: Double)

struct CurrencyPair {
    private(set) var currencyCodes: String
    private(set) var exchangeRate: Double
    
    var firstCurrencyCode: String {
        return String(currencyCodes.prefix(3))
    }
    
    var secondCurrencyCode: String {
        return String(currencyCodes.suffix(3))
    }
    
    var formattedExchangeRate: String {
        return String(exchangeRate)
    }
    
    init(with currencyPairAndRate: CurrencyPairAndRate) {
        self.init(with: currencyPairAndRate.currenyCodes,
                  exchangeRate: currencyPairAndRate.exchangeRate)
    }
    
    init(with currencyCodes: String, exchangeRate: Double) {
        self.currencyCodes = currencyCodes
        self.exchangeRate = exchangeRate
    }
}

extension CurrencyPair {
    static func sort(_ currencyPairs: [CurrencyPair], using currencyPairsInSelectedOrder: [String]) -> [CurrencyPair] {
        var sortedCurrencyPairs = [CurrencyPair]()
        for currencyPairString in currencyPairsInSelectedOrder {
            if let currencyPair = currencyPairs.first(where: { $0.currencyCodes == currencyPairString }) {
                sortedCurrencyPairs.append(currencyPair)
            }
        }
        return sortedCurrencyPairs
    }
}
