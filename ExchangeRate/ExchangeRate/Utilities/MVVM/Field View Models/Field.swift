//
//  Field.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import Foundation

class Field: FieldViewModelable {
    var id: String
    var title: String
    var detail: String
    
    init(with id: String = UUID().uuidString, title: String, detail: String) {
        self.id = id
        self.title = title
        self.detail = detail
    }
}
