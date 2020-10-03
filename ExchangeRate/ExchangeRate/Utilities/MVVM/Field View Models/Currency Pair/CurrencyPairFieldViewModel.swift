//
//  CurrencyPairFieldViewModel.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 14/03/2020.
//

import Foundation

final class CurrencyPairFieldViewModel: Field {
    var exchangeRate: String
    var firstCurrencyName: String
    var secondCurrencyName: String
    var secondCurrencyNameAndCode: String
    
    init(with currencyPairAndRate: CurrencyPair, firstCurrency: Currency, secondCurrency: Currency) {
        let title = "1 \(firstCurrency.code)"
        self.exchangeRate = currencyPairAndRate.formattedExchangeRate
        self.firstCurrencyName = firstCurrency.name
        self.secondCurrencyName = secondCurrency.name
        self.secondCurrencyNameAndCode = secondCurrency.nameAndCode
        super.init(with: currencyPairAndRate.currencyCodes,
                   title: title,
                   detail: exchangeRate)
    }
}
