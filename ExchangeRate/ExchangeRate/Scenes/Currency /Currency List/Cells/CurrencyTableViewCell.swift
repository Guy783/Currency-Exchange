//
//  TestTableViewCell.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 12/03/2020.
//

import UIKit

final class CurrencyTableViewCell: FieldCell {
    @IBOutlet private var flagImageView: UIImageView!
    @IBOutlet private var currencyCodeLabel: UILabel!
    @IBOutlet private var currencyNameLabel: UILabel!
    @IBOutlet private var fadedView: UIView!

    func update(with field: FieldViewModelable) {
        guard let currencyFieldViewModel = field as? CurrencyFieldViewModel else {
            return
        }
        if let image = UIImage(named: currencyFieldViewModel.imageURL) {
            flagImageView.image = image
        }
        currencyNameLabel.text = currencyFieldViewModel.title
        currencyCodeLabel.text = currencyFieldViewModel.detail
        fadedView.isHidden = !currencyFieldViewModel.isSelected
        makeAccessible(with: currencyFieldViewModel)
    }
    
    func makeAccessible(with field: FieldViewModelable) {
        guard let currencyFieldViewModel = field as? CurrencyFieldViewModel else {
            return
        }
        flagImageView.makeAccessible(accessibilityLabel: R.string.accessibility.currencyFlag(),
                                     accessibilityHint: R.string.accessibility.currencyFlagDescribed(currencyFieldViewModel.title))
        currencyNameLabel.makeAccessible(accessibilityLabel: R.string.accessibility.currencyName(),
                                         accessibilityHint: currencyFieldViewModel.title)
        currencyCodeLabel.makeAccessible(accessibilityLabel: R.string.accessibility.currencyCode(),
                                         accessibilityHint: currencyFieldViewModel.detail)
    }
}
