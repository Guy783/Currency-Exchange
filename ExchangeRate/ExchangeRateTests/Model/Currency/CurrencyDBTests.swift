//
//  CurrencyDBTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 08/03/2020.
//

import CoreData
import Foundation
import XCTest

@testable import ExchangeRate

class CurrencyDBTests: CoreDataTests {
    
    private var currencies: [Currency]!
    
    override func setUp() {
        super.setUp()
        do {
            currencies = try fetchCurrencies()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        currencies = nil
    }
}

// MARK: - Fetch Currencies
extension CurrencyDBTests {
    private func fetchCurrencies() throws -> [Currency] {
        guard let data = LocalMockService.fetchData(for: .currencies) else {
            throw FetchError.fetchFailed
        }
        return try JSONDecoder().decode([Currency].self, from: data)
    }
}

// MARK: - Create & Update Currency Tests
extension CurrencyDBTests {
    func test_createWithCurrency() {
        guard let currency = currencies.first else {
            return XCTFail("Currency array has no currencies")
        }
        let currencyDB = CurrencyDB.create(with: currency, in: coreDataManager.mainContext)
        XCTAssertEqual(currencyDB.id, currency.id)
        XCTAssertEqual(currencyDB.name, currency.name)
        XCTAssertEqual(currencyDB.code, currency.code)
    }

    func test_updateWithCurrency() {
        guard let currency = currencies.first else {
            return XCTFail("Currencies array is nil or empty")
        }
        let currencyDB = CurrencyDB.create(with: currency, in: coreDataManager.mainContext)
        
        var updatedCurrency = currency
        updatedCurrency.name = "New Country"
        updatedCurrency.code = "NC"
        
        currencyDB.update(with: updatedCurrency, in: coreDataManager.mainContext)
        
        XCTAssertEqual(currencyDB.id, updatedCurrency.id)
        XCTAssertEqual(currencyDB.name, updatedCurrency.name)
        XCTAssertEqual(currencyDB.code, updatedCurrency.code)
    }
}

// MARK: - Fetch & Update Currency Tests
extension CurrencyDBTests {
    func test_fetchCurrencyDB() {
        guard let currency = currencies.first else {
            return XCTFail("Currencies array is nil or empty")
        }
        let currencyDB = CurrencyDB.create(with: currency, in: coreDataManager.mainContext)
        guard let fetchedCurrencyDB = CurrencyDB.fetchCurrency(with: currency.id, in: coreDataManager.mainContext) else {
            return XCTFail("Failed to fetch currency")
        }
        XCTAssertEqual(fetchedCurrencyDB.id, currencyDB.id)
        XCTAssertEqual(fetchedCurrencyDB.name, currencyDB.name)
        XCTAssertEqual(fetchedCurrencyDB.code, currencyDB.code)
    }

    func test_fetchCurrencyDBs() {
        guard currencies.isEmpty == false else {
            return XCTFail("Failed to fetch currency")
        }
        for currency in currencies {
            _ = CurrencyDB.create(with: currency, in: coreDataManager.mainContext)
        }
        coreDataManager.save(context: coreDataManager.mainContext) {
            let fetchedCurrencies = CurrencyDB.fetchCurrencies(in: self.coreDataManager.mainContext)
            XCTAssertEqual(self.currencies.count, fetchedCurrencies.count)
        }
    }
}
