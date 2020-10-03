//
//  AddItemTableViewCell.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 17/03/2020.
//

import UIKit

class AddItemTableViewCell: FieldCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var addItemImageView: UIImageView!
    
    func update(with field: FieldViewModelable) {
        titleLabel.text = field.title
        makeAccessible(with: field)
    }
    
    func makeAccessible(with field: FieldViewModelable) {
        addItemImageView.makeAccessible(accessibilityLabel: R.string.accessibility.currencyAdd(),
                                        accessibilityHint: field.title)
        titleLabel.makeAccessible(accessibilityLabel: R.string.accessibility.currencyAdd(),
                                  accessibilityHint: field.title)
    }
}
