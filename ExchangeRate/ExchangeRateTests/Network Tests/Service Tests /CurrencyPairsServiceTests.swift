//
//  CurrencyPairsServiceTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 22/03/2020.
//  Copyright © 2020 Takomborerwa. All rights reserved.
//

import UIKit
import XCTest
@testable import ExchangeRate

class CurrencyPairsServiceTests: XCTestCase {}

extension CurrencyPairsServiceTests {
    func test_fetchCurrencyPairs() {
        let didFinish = expectation(description: #function)
        var handler: ([CurrencyPair]?, Error?)?
        
        CurrencyPairsService.fetchCurrencyPairs(with: "?pairs=USDGBP&pairs=GBPUSD") { (result, error) in
            if let requestError = error {
                handler = (nil, requestError)
            } else {
                guard let currencyPairs = result as? [CurrencyPair] else {
                    return
                }
                handler = (currencyPairs, nil)
            }
            didFinish.fulfill()
        }
        
        wait(for: [didFinish], timeout: 5)
        
        XCTAssertNotNil(handler?.0)
    }
}
