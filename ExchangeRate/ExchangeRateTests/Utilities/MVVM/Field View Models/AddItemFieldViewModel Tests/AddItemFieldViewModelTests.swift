//
//  AddItemFieldViewModelTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 21/03/2020.
//  Copyright © 2020 Takomborerwa. All rights reserved.
//

import XCTest

@testable import ExchangeRate

class AddItemFieldViewModelTests: XCTestCase {}

// MARK: - Init Tests
extension AddItemFieldViewModelTests {
    func test_initWithVariables() {
        let title = R.string.localised.currenciesAdd()
        let field = AddItemFieldViewModel(with: .currencyPair, title: title)
        
        XCTAssertEqual(field.itemToAddFieldType, .currencyPair)
        XCTAssertEqual(field.title, title)
        XCTAssertEqual(field.detail, String())
    }
}
