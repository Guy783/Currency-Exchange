//
//  CurrencyPairsTableViewCell.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 14/03/2020.
//

import UIKit

class CurrencyPairsTableViewCell: FieldCell {
    @IBOutlet private var oneUnitLabel: UILabel!
    @IBOutlet private var exchangeRateLabel: UILabel!
    @IBOutlet private var firstCurrencyNameLabel: UILabel!
    @IBOutlet private var secondCurrencyNameAndCodeLabel: UILabel!
    
     static var exchangeRateLabelStringFirstAttributes: [NSAttributedString.Key: Any] = {
         return [.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: R.font.robotoRegular(size: 20)!)]
     }()
     
     static var exchangeRateLabelStringSecondAttributes: [NSAttributedString.Key: Any] = {
         return [.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: R.font.robotoRegular(size: 14)!)]
     }()
    
    /// Spacing to be used in between two attributed strings - method exists to be used to meet design requirements
    static var spacingAtttributedString: NSAttributedString = {
        let spaceAttributes: [NSAttributedString.Key: Any] = [.font: R.font.robotoRegular(size: 2)!]
        let spacing = NSMutableAttributedString(string: String(" "), attributes: spaceAttributes)
        let range = NSRange(location: 0, length: spacing.length)
        spacing.addAttribute(.kern, value: NSNumber(value: 1.0), range: range)
        return spacing
    }()
}

// MARK: - Public Methods
extension CurrencyPairsTableViewCell {
    func update(with field: FieldViewModelable) {
        guard let currencyPairsListViewModel = field as? CurrencyPairFieldViewModel else {
            return
        }
        makeAccessible(with: field)
        oneUnitLabel.text = currencyPairsListViewModel.title
        firstCurrencyNameLabel.text = currencyPairsListViewModel.firstCurrencyName
        secondCurrencyNameAndCodeLabel.text = currencyPairsListViewModel.secondCurrencyNameAndCode
        exchangeRateLabel.attributedText = exchangeRateAttributedString(with: currencyPairsListViewModel.detail)
    }
    
    func makeAccessible(with field: FieldViewModelable) {
        guard let currencyPairsListViewModel = field as? CurrencyPairFieldViewModel else {
            return
        }
        let exchangeRate = R.string.accessibility.currencyPairExchangeRateEquals(currencyPairsListViewModel.firstCurrencyName,
                                                                                 currencyPairsListViewModel.exchangeRate + " " + currencyPairsListViewModel.secondCurrencyName)
        exchangeRateLabel.makeAccessible(accessibilityLabel: exchangeRate, accessibilityHint: exchangeRate)
        oneUnitLabel.makeAccessible(accessibilityLabel: currencyPairsListViewModel.title,
                                    accessibilityHint: currencyPairsListViewModel.title)
        firstCurrencyNameLabel.makeAccessible(accessibilityLabel: R.string.accessibility.currencyPairSecondCurrencyNameAndCode(),
                                              accessibilityHint: currencyPairsListViewModel.firstCurrencyName)
        secondCurrencyNameAndCodeLabel.makeAccessible(accessibilityLabel: R.string.accessibility.currencyPairSecondCurrencyNameAndCode(),
                                                      accessibilityHint: currencyPairsListViewModel.secondCurrencyNameAndCode)
    }
}

// MARK: - Helpers
extension CurrencyPairsTableViewCell {
    private func exchangeRateAttributedString(with exchangeRate: String) -> NSAttributedString {
        let numberParts = exchangeRate.components(separatedBy: ".")
        // Check that the string after being split has two parts
        guard numberParts.count == 2 else {
            return NSAttributedString(string: exchangeRate.replacingOccurrences(of: ".", with: ","))
        }
        let wholeNumberPart = numberParts[0] // i.e. 3.1415 -> 3
        let decimalPart = numberParts[1] // i.e. 3.1415 -> 1415
        
        // Check that there are at least two decimal points
        guard decimalPart.count > 2 else {
            return NSAttributedString(string: exchangeRate.replacingOccurrences(of: ".", with: ","))
        }
        
        // Create attributed string the have the last two numbers in a smaller font
        let firstDecimals = decimalPart.prefix(2) // // i.e. 3.1415 -> 14
        let lastDecimals = decimalPart.dropFirst(2) // i.e. 3.1415 -> 15
        
        let firstString = NSAttributedString(string: String(wholeNumberPart + "," + firstDecimals),
                                             attributes: CurrencyPairsTableViewCell.exchangeRateLabelStringFirstAttributes)
        let secondString = NSAttributedString(string: String(lastDecimals),
                                              attributes: CurrencyPairsTableViewCell.exchangeRateLabelStringSecondAttributes)
        
        let finalString = NSMutableAttributedString()
        finalString.append(firstString)
        finalString.append(CurrencyPairsTableViewCell.spacingAtttributedString)
        finalString.append(secondString)
    
        return finalString
    }
}
