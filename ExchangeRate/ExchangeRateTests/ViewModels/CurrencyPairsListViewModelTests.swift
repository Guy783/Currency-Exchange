//
//  CurrencyPairsListViewModelTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 14/03/2020.
//

import XCTest

@testable import ExchangeRate
class CurrencyPairsListViewModelTests: XCTestCase {}

// MARK: - Initialisation Tests
extension CurrencyPairsListViewModelTests {
    func test_initialisation() {
        let countOfItemsAddedInsideViewModel = 1
        let currencyA = Currency(with: "1", name: "Great Britain Pound", code: "GBP")
        let currencyB = Currency(with: "2", name: "Euro", code: "EUR")
        let currencies = [currencyA, currencyB]
        
        let currencyPair = "GBPEUR"
        let currencyPairStrings = [currencyPair]
        let currencyPairA = CurrencyPair(with: currencyPair, exchangeRate: 1.1625)
        let currencyPairs = [currencyPairA]
        
        let currencyListViewModel = CurrencyPairsListViewModel(with: currencyPairs, and: currencies, with: currencyPairStrings)
        
        XCTAssertEqual(currencyListViewModel.numberOfSections(), 1)
        XCTAssertEqual(currencyListViewModel.numberOfItems(in: 0), currencyPairs.count + countOfItemsAddedInsideViewModel)
    }
    
    func test_updateViewModel() {
        let currencyPairAString = "GBPEUR"
        let currencyPairBString = "USDEUR"
        let currencyPairStringsA = [currencyPairAString]
        let currencyPairStringsB = [currencyPairBString, currencyPairAString] // Note: - These the currency pair order is reversed
        
        let currencyA = Currency(with: "1", name: "Great Britain Pound", code: "GBP")
        let currencyB = Currency(with: "2", name: "Euro", code: "EUR")
        let currencyC = Currency(with: "3", name: "United States Dollar", code: "USD")
        let currencies = [currencyA, currencyB, currencyC]
        
        let currencyPairA = CurrencyPair(with: currencyPairAString, exchangeRate: 1.1625)
        let currencyPairB = CurrencyPair(with: currencyPairBString, exchangeRate: 2.2115)
        let currencyPairsA = [currencyPairA]
        let currencyPairsB = [currencyPairA, currencyPairB]
        
        let currencyListViewModel = CurrencyPairsListViewModel(with: currencyPairsA, and: currencies, with: currencyPairStringsA)
        // Note that we are using currencyPairStringsB, which has the reverse order of currencyPairsB
        currencyListViewModel.update(with: currencyPairsB, with: currencyPairStringsB)
        
        guard let firstField = currencyListViewModel.item(for: IndexPath(item: 1, section: 0)) as? CurrencyPairFieldViewModel else {
            return XCTFail("CurrencyPairsListViewModel failed to create AddItemFieldViewModel field")
        }
        XCTAssertEqual(firstField.id, currencyPairStringsB[0])

        guard let secondField = currencyListViewModel.item(for: IndexPath(item: 2, section: 0)) as? CurrencyPairFieldViewModel else {
            return XCTFail("CurrencyPairsListViewModel failed to create CurrencyPairFieldViewModel field")
        }
        XCTAssertEqual(secondField.id, currencyPairStringsB[1])
    }
    
    func test_sectionOne() {
        let countOfItemsAddedInsideViewModel = 1
        let currencyA = Currency(with: "1", name: "Great Britain Pound", code: "GBP")
        let currencyB = Currency(with: "2", name: "Euro", code: "EUR")
        let currencies = [currencyA, currencyB]
        
        let currencyPairA = CurrencyPair(with: "GBPEUR", exchangeRate: 1.1625)
        let currencyPairs = [currencyPairA]
        let title = "Section One"

        let currencyPairsSection = CurrencyPairsListViewModel.currencyPairsSection(with: currencyPairs, and: currencies, title: title)
        XCTAssertEqual(currencyPairsSection.title, title)
        guard (currencyPairsSection.fields.first as? AddItemFieldViewModel) != nil else {
            return XCTFail("CurrencyPairsListViewModel failed to create AddItemFieldViewModel field")
        }
        guard let secondField = currencyPairsSection.fields[1] as? CurrencyPairFieldViewModel else {
            return XCTFail("CurrencyPairsListViewModel failed to create CurrencyPairFieldViewModel field")
        }
        XCTAssertEqual(currencyPairsSection.fields.count, 1 + countOfItemsAddedInsideViewModel)
        XCTAssertEqual(secondField.id, currencyPairA.currencyCodes)
    }
}
