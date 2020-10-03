//
//  CurrencyPairsHandlerTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 15/03/2020.
//  Copyright © 2020 Takomborerwa. All rights reserved.
//

import os
import XCTest
@testable import ExchangeRate

class CurrencyPairsHandlerTests: XCTestCase {
    private var userCurrencyPairs: UserCurrencyPairs!
    
    override func setUp() {
        super.setUp()
        let selectedCurrencyPairs = ["USDGBP", "GBPUSD"]
        userCurrencyPairs = UserCurrencyPairs(selectedPairs: selectedCurrencyPairs)
    }
    
    override func tearDown() {
        super.tearDown()
        userCurrencyPairs = nil
    }
}

// MARK: - Test UserCurrencyPairs Mutating Functions
extension CurrencyPairsHandlerTests {
    func test_addOneCurrency() {
        let currencyA = Currency(name: "British Pound", code: "GBP")
        
        var currencyPairsHandler = CurrencyPairsHandler(selectedCurrencies: [],
                                                        selectedCurrencyPairs: userCurrencyPairs)
        let localHandler = currencyPairsHandler
        currencyPairsHandler.addSelectedCurrency(currencyA) { didAddCurrency, didAddNewCurrencyPair  in
            guard let firstCurrency = localHandler.selectedCurrencies.first else {
                return
            }
            XCTAssertTrue(didAddCurrency)
            XCTAssertFalse(didAddNewCurrencyPair)
            XCTAssertEqual(firstCurrency.id, currencyA.id)
            XCTAssertEqual(localHandler.selectedCurrencies.count, 1)
        }
    }
    
    func test_addTwoCurrencies() {
        let currencyA = Currency(name: "British Pound", code: "GBP")
        let currencyB = Currency(name: "Euro", code: "EUR")
        
        var currencyPairsHandler = CurrencyPairsHandler(selectedCurrencies: [],
                                                        selectedCurrencyPairs: userCurrencyPairs)
        currencyPairsHandler.addSelectedCurrency(currencyA) { didAddCurrency, didAddNewCurrencyPair in
            XCTAssertFalse(didAddNewCurrencyPair)
        }
        
        currencyPairsHandler.addSelectedCurrency(currencyB) { didAddCurrency, didAddNewCurrencyPair in
            XCTAssertTrue(didAddCurrency)
            XCTAssertTrue(didAddNewCurrencyPair)
        }
    }
    
    func test_addExistingCurrency() {
        let currencyA = Currency(name: "British Pound", code: "GBP")
        var currencyPairsHandler = CurrencyPairsHandler(selectedCurrencies: [],
                                                        selectedCurrencyPairs: userCurrencyPairs)
        currencyPairsHandler.addSelectedCurrency(currencyA) { didAddCurrency, didAddNewCurrencyPair in
            XCTAssertTrue(didAddCurrency)
            XCTAssertFalse(didAddNewCurrencyPair)
        }
       
        let localHandler = currencyPairsHandler
        currencyPairsHandler.addSelectedCurrency(currencyA) { didAddCurrency, didAddNewCurrencyPair in
            XCTAssertFalse(didAddCurrency)
            XCTAssertFalse(didAddNewCurrencyPair)
            XCTAssertEqual(localHandler.selectedCurrencies.count, 1)
        }
    }
}
