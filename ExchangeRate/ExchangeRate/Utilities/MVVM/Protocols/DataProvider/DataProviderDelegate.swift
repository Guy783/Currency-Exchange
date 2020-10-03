//
//  DataProviderDelegate.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 12/03/2020.
//

import UIKit

protocol DataProviderDelegate: class {
    func reloadData()
    func didSelect(_ field: Field)
}
