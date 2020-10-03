//
//  AddItemField.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 17/03/2020.
//  Copyright © 2020 Takomborerwa. All rights reserved.
//

import Foundation

enum ItemToAddFieldType {
    case currencyPair
}

class AddItemFieldViewModel: Field {
    var itemToAddFieldType: ItemToAddFieldType
    
    init(with itemToAddFieldType: ItemToAddFieldType, title: String) {
        self.itemToAddFieldType = itemToAddFieldType
        super.init(title: title, detail: String())
    }
}
