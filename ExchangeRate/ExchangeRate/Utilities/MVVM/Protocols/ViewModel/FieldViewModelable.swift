//
//  FieldViewModel.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import Foundation

protocol FieldViewModelable {
    var id: String { get set }
    var title: String { get set }
    var detail: String { get set }
}
