//
//  CurrencyListViewModel.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import Foundation

final class CurrencyListViewModel: BaseViewModel {
    init(with currencies: [Currency], selectedCurrencies: [Currency]) {
        super.init(with: [SectionItem]())
        sections.append(CurrencyListViewModel.currenciesSection(with: currencies, selectedCurrencies: selectedCurrencies, title: ""))
    }
}

// MARK: Sections
extension CurrencyListViewModel {
    static func currenciesSection(with currencies: [Currency], selectedCurrencies: [Currency], title: String) -> SectionItem {
        var fields = [CurrencyFieldViewModel]()
        for currency in currencies {
            var isSelected = false
            if Currency.fetchCurrency(with: currency.code, from: selectedCurrencies) != nil {
                isSelected = true
            }
            let currencyFieldViewModel = CurrencyFieldViewModel(with: currency, isSelected: isSelected)
            fields.append(currencyFieldViewModel)
        }
        return SectionItem(title: title,
                           fields: fields)
    }
}
