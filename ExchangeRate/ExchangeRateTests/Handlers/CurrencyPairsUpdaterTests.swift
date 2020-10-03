//
//  CurrencyPairsUpdaterTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 18/03/2020.
//  Copyright © 2020 Takomborerwa. All rights reserved.
//

import os
import XCTest
@testable import ExchangeRate

class CurrencyPairsUpdaterTests: XCTestCase {
    private var currencyPairs: String!
    private var currencyPairsUpdater: CurrencyPairsUpdater!
    private var testCurrencyPairsUpdaterDelegate: TestCurrencyPairsUpdaterDelegate!
    
    override func setUp() {
        currencyPairs = "?pairs=USDGBP&pairs=GBPUSD"
        testCurrencyPairsUpdaterDelegate = TestCurrencyPairsUpdaterDelegate()
        currencyPairsUpdater = CurrencyPairsUpdater(currencyPairs: currencyPairs, delegate: testCurrencyPairsUpdaterDelegate)
    }

    override func tearDown() {
        currencyPairs = nil
        currencyPairsUpdater = nil
        testCurrencyPairsUpdaterDelegate = nil
    }
}

extension CurrencyPairsUpdaterTests {
    func test_initCurrencyPairsUpdater() {
        let tempCurrencyPairsUpdater = CurrencyPairsUpdater(currencyPairs: currencyPairs, delegate: testCurrencyPairsUpdaterDelegate)
        XCTAssertEqual(tempCurrencyPairsUpdater.currencyPairs, currencyPairs)
        XCTAssertNotNil(tempCurrencyPairsUpdater.delegate)
    }
    
    func test_runTimer() {
        currencyPairsUpdater.runTimer(with: currencyPairs)
        XCTAssertTrue(currencyPairsUpdater.timerIsValid())
    }
    
    func test_updaterSucceeds() {
        currencyPairsUpdater.runTimer(with: currencyPairs)
        /**
        _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
            XCTAssertTrue(self.testCurrencyPairsUpdaterDelegate.hasNewCurrencyPairs)
        } **/
    }
    
    func test_stopTimer() {
        currencyPairsUpdater.runTimer(with: currencyPairs)
        currencyPairsUpdater.stopTimer()
        XCTAssertFalse(currencyPairsUpdater.timerIsValid())
    }
}

class TestCurrencyPairsUpdaterDelegate: CurrencyPairsUpdaterDelegate {
    var hasNewCurrencyPairs: Bool = false
    
    func didReturnNewCurrencyPairs(_ currencyPairs: [CurrencyPair]) {
        hasNewCurrencyPairs = true
    }
    
    func didReturnFailToReloadCurrencyPairs(with errorMessage: String) {}
}
