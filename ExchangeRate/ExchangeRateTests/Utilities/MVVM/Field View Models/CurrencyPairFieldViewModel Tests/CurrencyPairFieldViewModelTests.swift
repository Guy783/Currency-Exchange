//
//  CurrencyPairFieldViewModelTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 14/03/2020.
//

import XCTest

@testable import ExchangeRate

class CurrencyPairFieldViewModelTests: XCTestCase {}

// MARK: - Init Tests
extension CurrencyPairFieldViewModelTests {
    func test_initWithVariables() {
        let currencyPair = CurrencyPair(with: "GBPEUR", exchangeRate: 1.1627)
        let firstCurrency = Currency(name: "British Pound", code: "GBP")
        let secondCurrency = Currency(name: "Euro", code: "EUR")
        let currencyPairFieldViewModel = CurrencyPairFieldViewModel(with: currencyPair, firstCurrency: firstCurrency, secondCurrency: secondCurrency)
        
        XCTAssertEqual(currencyPairFieldViewModel.id, currencyPair.currencyCodes)
        XCTAssertEqual(currencyPairFieldViewModel.title, "1 \(firstCurrency.code)")
        XCTAssertEqual(currencyPairFieldViewModel.detail, currencyPair.formattedExchangeRate)
        XCTAssertEqual(currencyPairFieldViewModel.firstCurrencyName, firstCurrency.name)
        XCTAssertEqual(currencyPairFieldViewModel.secondCurrencyNameAndCode, secondCurrency.nameAndCode)
    }
}
