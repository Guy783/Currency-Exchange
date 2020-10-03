//
//  CurrencyTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 07/03/2020.
//

import XCTest
@testable import ExchangeRate

class CurrencyTests: CoreDataTests {
    private var currenciesResponse: Data!
    
    override func setUp() {
        super.setUp()
        do {
            currenciesResponse = try fetchCurrenciesData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        currenciesResponse = nil
    }
}

// MARK: - Fetch Currencies
extension CurrencyTests {
    private func fetchCurrenciesData() throws -> Data {
        guard let data = LocalMockService.fetchData(for: .currencies) else {
            throw FetchError.fetchFailed
        }
        return data
    }
}

// MARK: - Init Tests
extension CurrencyTests {
    func test_initWithVariables() {
        let id = UUID().uuidString
        let name = "British Pound"
        let code = "GBP"
        let currency = Currency(with: id, name: name, code: code)
        
        XCTAssertEqual(currency.id, id)
        XCTAssertEqual(currency.code, code)
        XCTAssertEqual(currency.name, name)
    }
    
    func test_decodeCurrencies() {
        do {
            let currencies = try JSONDecoder().decode([Currency].self, from: currenciesResponse)
            guard let currency = currencies.first else {
                return XCTFail("No currencies returned")
            }
            
            XCTAssertEqual(currency.id, "1")
            XCTAssertEqual(currency.code, "GBP")
            XCTAssertEqual(currency.name, "British Pound")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_initWithCurrencyDB() {
        do {
            let currencies = try JSONDecoder().decode([Currency].self, from: currenciesResponse)
            guard let currencyA = currencies.first else {
                return XCTFail("No currencies returned")
            }
            let currencyDB = CurrencyDB.create(with: currencyA, in: coreDataManager.mainContext)
            let currencyB = Currency(currencyDB)
        
            XCTAssertEqual(currencyB.id, currencyDB.id)
            XCTAssertEqual(currencyB.code, currencyDB.code)
            XCTAssertEqual(currencyB.name, currencyDB.name)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

// MARK: - Helper Method Tests
extension CurrencyTests {
    func test_currencyNameAndCode() {
        let name = "British Pound"
        let code = "GBP"
        let currency = Currency(name: name, code: code)
        let nameAndCode = currency.nameAndCode
        XCTAssertEqual(nameAndCode, "\(name) ∙ \(code)")
    }
    
    func test_fetchCurrencyWithCode_succeeds() {
        let searchCode = "GBP"
        let currency = Currency(name: "British Pound", code: searchCode)
        
        guard let fetchedCurrency = Currency.fetchCurrency(with: searchCode, from: [currency]) else {
            return XCTFail("Failed to fetch currency")
        }
        XCTAssertEqual(fetchedCurrency.code, searchCode)
    }
    
    func test_fetchCurrencyWithCode_fails() {
        let currencyCode = "GBP"
        let currency = Currency(name: "British Pound", code: currencyCode)
        let searchCode = "ABCDEFGHIJKLMNO"
        XCTAssertNil(Currency.fetchCurrency(with: searchCode, from: [currency]))
    }
}

// MARK: - Service Method Tests
extension CurrencyTests {
    func test_fetchCurrencyFromCurrencies() {
        do {
            let currencies = try JSONDecoder().decode([Currency].self, from: currenciesResponse)
            guard let currency = currencies.first else {
                return XCTFail("No currencies returned")
            }
            guard let fetchedCurrency = Currency.fetchCurrency(with: currency.code, from: currencies) else {
                return XCTFail("Currency not found in passed in Currency array")
            }
            XCTAssertEqual(currency.id, fetchedCurrency.id)
            XCTAssertEqual(currency.code, fetchedCurrency.code)
            XCTAssertEqual(currency.name, fetchedCurrency.name)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
