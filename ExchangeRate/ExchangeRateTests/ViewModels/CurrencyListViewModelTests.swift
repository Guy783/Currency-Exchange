//
//  CurrencyListViewModelTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 14/03/2020.
//

import XCTest

@testable import ExchangeRate
class CurrencyListViewModelTests: XCTestCase {}

// MARK: - Initialisation Tests
extension CurrencyListViewModelTests {
    func test_initialisation() {
        let currencyA = Currency(with: "1", name: "GBP", code: "Great Britain Pound")
        let currencyB = Currency(with: "2", name: "Swedish Krona", code: "SEK")
        let currencyC = Currency(with: "3", name: "Danish Krone", code: "DKK")
        let currencies = [currencyA, currencyB, currencyC]
        
        let currencyListViewModel = CurrencyListViewModel(with: currencies, selectedCurrencies: [currencyA])
        
        XCTAssertEqual(currencyListViewModel.numberOfSections(), 1)
        XCTAssertEqual(currencyListViewModel.numberOfItems(in: 0), currencies.count)
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        guard let firstField = currencyListViewModel.item(for: firstIndexPath) as? CurrencyFieldViewModel else {
            XCTFail("CurrencyFieldViewModel failed to create field")
            return
        }
        XCTAssertEqual(firstField.id, currencyA.id)
    }
    
    func test_sectionOne() {
        let currencyA = Currency(with: "1", name: "GBP", code: "Great Britain Pound")
        let currencies = [currencyA]
        let title = "Section One"
        
        let currenciesSection = CurrencyListViewModel.currenciesSection(with: currencies, selectedCurrencies: [currencyA], title: title)
        XCTAssertEqual(currenciesSection.title, title)
        guard let firstField = currenciesSection.fields.first else {
            return XCTFail("CurrencyPairsListViewModel failed to create field")
        }
        XCTAssert(firstField is CurrencyFieldViewModel)
        XCTAssertEqual(currenciesSection.fields.count, 1)
    }
}
