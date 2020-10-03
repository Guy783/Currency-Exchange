//
//  CurrencyPairTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 14/03/2020.
//

import XCTest
@testable import ExchangeRate

class CurrencyPairTests: CoreDataTests {
    private var currencyPairsResponse: Data!
    
    override func setUp() {
        super.setUp()
        do {
            currencyPairsResponse = try fetchCurrencyPairsData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        currencyPairsResponse = nil
    }
}

// MARK: - Fetch Currencies
extension CurrencyPairTests {
    private func fetchCurrencyPairsData() throws -> Data {
        guard let data = LocalMockService.fetchData(for: .currencyPairs) else {
            throw FetchError.fetchFailed
        }
        return data
    }
}

// MARK: - Init Tests
extension CurrencyPairTests {
    func test_initWithVariables() {
        let currencyCodes = "GBPEUR"
        let exchangeRate = 1.1625
        let currencyPair = CurrencyPair(with: currencyCodes, exchangeRate: exchangeRate)
        
        XCTAssertEqual(currencyPair.exchangeRate, 1.1625)
        XCTAssertEqual(currencyPair.firstCurrencyCode, "GBP")
        XCTAssertEqual(currencyPair.secondCurrencyCode, "EUR")
        XCTAssertEqual(currencyPair.formattedExchangeRate, "1.1625")
    }
    
    func test_initWithKeyValuePairs() {
        do {
            let currencyResponseKeyValuePairs = try JSONDecoder().decode([String: Double].self, from: currencyPairsResponse)
            guard let firstKeyValuePair = currencyResponseKeyValuePairs.first else {
                return XCTFail("No currency pairs returned")
            }
            let currencyPairAndRate = CurrencyPairAndRate(currenyCodes: firstKeyValuePair.key, exchangeRate: firstKeyValuePair.value )
            let currencyPair = CurrencyPair(with: currencyPairAndRate)
            XCTAssertEqual(currencyPair.exchangeRate, currencyPairAndRate.exchangeRate)
            XCTAssertEqual(currencyPair.firstCurrencyCode, String(currencyPairAndRate.currenyCodes.prefix(3)))
            XCTAssertEqual(currencyPair.secondCurrencyCode, String(currencyPairAndRate.currenyCodes.suffix(3)))
            XCTAssertEqual(currencyPair.formattedExchangeRate, String(currencyPair.exchangeRate))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

// MARK: - Helper Method Tests
extension CurrencyPairTests {
    func test_sortCurrencyPairs() {
        let currencyPairAString = "GBPEUR"
        let currencyPairBString = "USDEUR"
        let currencyPairStrings = [currencyPairBString, currencyPairAString]
        
        let currencyPairA = CurrencyPair(with: currencyPairAString, exchangeRate: 1.1625)
        let currencyPairB = CurrencyPair(with: currencyPairBString, exchangeRate: 2.2115)
        let currencyPairs = [currencyPairA, currencyPairB] // Note: - These the currency pair order is reversed in contrast to currencyPairStringsA
        
        let sortedPairs = CurrencyPair.sort(currencyPairs, using: currencyPairStrings)
        
        XCTAssertEqual(sortedPairs.count, currencyPairs.count)

        guard let firstPair = sortedPairs.first else {
            return XCTFail("CurrencyPair.sort failed return first item")
        }
        XCTAssertEqual(firstPair.currencyCodes, currencyPairStrings[0])

        let secondPair = sortedPairs[1]
        XCTAssertEqual(secondPair.currencyCodes, currencyPairStrings[1])
    }
}
