//
//  CurrencyFieldViewModelTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import XCTest

@testable import ExchangeRate

class CurrencyFieldViewModelTests: XCTestCase {}

// MARK: - Create & Update Currency Tests
extension CurrencyFieldViewModelTests {
    func test_initWithCurrency() {
        let isSelected = false
        let currency = Currency(with: "1", name: "Pound Sterling", code: "GBP")
        let currencyFieldViewModel = CurrencyFieldViewModel(with: currency, isSelected: isSelected)
        XCTAssertEqual(currencyFieldViewModel.id, currency.id)
        XCTAssertEqual(currencyFieldViewModel.title, currency.name)
        XCTAssertEqual(currencyFieldViewModel.detail, currency.code)
        XCTAssertEqual(currencyFieldViewModel.isSelected, isSelected)
    }
}
