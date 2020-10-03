//
//  CurrencyPairsViewModel.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 14/03/2020.
//

import Foundation

final class CurrencyPairsListViewModel: BaseViewModel {
    private(set) var currencies: [Currency]
    private(set) var currencyPairs: [CurrencyPair]
    
    init(with currencyPairs: [CurrencyPair], and currencies: [Currency], with currencyPairsInSelectedOrder: [String]) {
        self.currencies = currencies
        self.currencyPairs = currencyPairs
        super.init(with: [SectionItem]())
        
        self.update(with: currencyPairs, with: currencyPairsInSelectedOrder)
    }
    
    func update(with updatedCurrencyPairs: [CurrencyPair], with currencyPairsInSelectedOrder: [String]) {
        let sortedCurrencyPairs = CurrencyPair.sort(updatedCurrencyPairs, using: currencyPairsInSelectedOrder)
        currencyPairs = updatedCurrencyPairs
        sections = [SectionItem]()
        sections.append(
            CurrencyPairsListViewModel.currencyPairsSection(with: sortedCurrencyPairs,
                                                            and: currencies,
                                                            title: R.string.localised.currenciesTitle())
        )
    }
}

// MARK: Sections
extension CurrencyPairsListViewModel {
    static func currencyPairsSection(with currencyPairs: [CurrencyPair], and currencies: [Currency], title: String) -> SectionItem {
        var fields = [Field]()
        
        let addCurrencyPairField = AddItemFieldViewModel(with: .currencyPair, title: R.string.localised.currenciesAdd())
        fields.append(addCurrencyPairField)
        
        for currencyPair in currencyPairs {
            guard
                let firstCurrency = Currency.fetchCurrency(with: currencyPair.firstCurrencyCode, from: currencies),
                let secondCurrency = Currency.fetchCurrency(with: currencyPair.secondCurrencyCode, from: currencies) else {
                    continue
            }
            let currencyPairFieldViewModel = CurrencyPairFieldViewModel(with: currencyPair,
                                                                        firstCurrency: firstCurrency,
                                                                        secondCurrency: secondCurrency)
            fields.append(currencyPairFieldViewModel)
        }
        return SectionItem(title: title,
                           fields: fields)
    }
}
