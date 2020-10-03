//
//  FieldCell.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 17/03/2020.
//

import UIKit

typealias FieldCell = UITableViewCell & FieldUpdateable

protocol FieldUpdateable: class {
    func update(with field: FieldViewModelable)
    func makeAccessible(with field: FieldViewModelable)
}
