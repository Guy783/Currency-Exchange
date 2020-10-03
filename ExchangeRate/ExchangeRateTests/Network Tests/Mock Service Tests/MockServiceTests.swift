//
//  MockServiceTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 22/03/2020.
//  Copyright © 2020 Takomborerwa. All rights reserved.
//

import UIKit
import XCTest
@testable import ExchangeRate

class MockServiceTests: XCTestCase {}

extension MockServiceTests {
    func test_fetchData() {
        guard let data = LocalMockService.fetchData(for: .currencies) else {
            return XCTFail("Could not fetch data")
        }
        do {
            let currencies = try JSONDecoder().decode([Currency].self, from: data)
            XCTAssertTrue(currencies.count > 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_fetchCurrencyPairs() {
        let didFinish = expectation(description: #function)
        var handler: ([CurrencyPair]?, Error?)?
        
        LocalMockService.fetchLocalCurrencyPairs(with: "?pairs=USDGBP&pairs=GBPUSD") { (result, error) in
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
