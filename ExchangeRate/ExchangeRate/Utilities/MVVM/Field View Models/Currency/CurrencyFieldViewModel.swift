//
//  CurrencyFieldViewModel.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import UIKit

final class CurrencyFieldViewModel: Field {
    var isSelected: Bool
    var imageURL: String
    
    init(with currency: Currency, isSelected: Bool) {
        self.isSelected = isSelected
        self.imageURL = currency.code
        super.init(with: currency.id, title: currency.name, detail: currency.code)
    }
}
