//
//  DataProvidable.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import Foundation

protocol DataProvidable: class {
    var viewModel: ViewModelable { get set }
}
