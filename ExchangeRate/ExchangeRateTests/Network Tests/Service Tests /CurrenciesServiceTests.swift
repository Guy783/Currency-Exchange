//
//  CurrenciesServiceTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 22/03/2020.
//  Copyright © 2020 Takomborerwa. All rights reserved.
//

import UIKit
import XCTest
@testable import ExchangeRate

class CurrenciesServiceTests: XCTestCase {}

extension CurrenciesServiceTests {
    func test_fetchAllCurrencies() {
        let didFinish = expectation(description: #function)
        var handler: ([Currency]?, Error?)?
        
        CurrenciesService.fetchAllCurrencies { result, error in
            if let requestError = error {
                handler = (nil, requestError)
            } else {
                guard let currencies = result as? [Currency] else {
                    return
                }
                handler = (currencies, nil)
            }
            didFinish.fulfill()
        }
        
        wait(for: [didFinish], timeout: 5)
        
        XCTAssertNotNil(handler?.0)
    }
}
