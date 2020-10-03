//
//  UserCurrencyPairsTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 15/03/2020.
//

import XCTest
@testable import ExchangeRate

class UserCurrencyPairsTests: XCTestCase {
    private(set) var selectedCurrencyPairs: [String]!
    
    override func setUp() {
        super.setUp()
        selectedCurrencyPairs = ["USDGBP", "GBPUSD"]
    }
    
    override func tearDown() {
        super.tearDown()
        selectedCurrencyPairs = nil
    }
}

// MARK: - Test UserCurrencyPairs Mutating Functions
extension UserCurrencyPairsTests {
    func test_addCurrencyPair() {
        var userCurrencyPairs = UserCurrencyPairs(selectedPairs: selectedCurrencyPairs)
        let currencyA = Currency(name: "British Pound", code: "GBP")
        let currencyB = Currency(name: "Euro", code: "EUR")
        userCurrencyPairs.addNewCurrencyPair(with: currencyA, currencyTwo: currencyB)
        
        guard let firstCurrencyPair = userCurrencyPairs.selectedPairs.first else {
            return
        }
        
        let expectedPair = "\("GBP")\("EUR")"
        XCTAssertEqual(firstCurrencyPair, expectedPair)
    }
    
    func test_addTwoCurrencyPairs() {
        var userCurrencyPairs = UserCurrencyPairs(selectedPairs: selectedCurrencyPairs)
        let currencyA = Currency(name: "British Pound", code: "GBP")
        let currencyB = Currency(name: "Euro", code: "EUR")
        
        userCurrencyPairs.addNewCurrencyPair(with: currencyA, currencyTwo: currencyB)
        
        let currencyC = Currency(name: "Danish Krone", code: "DKK")
        let currencyD = Currency(name: "Singapore Dollar", code: "SGD")
        userCurrencyPairs.addNewCurrencyPair(with: currencyC, currencyTwo: currencyD)
        
        guard let firstCurrencyPair = userCurrencyPairs.selectedPairs.first else {
            return
        }
        let expectedFirstPair = "\("DKK")\("SGD")"
        XCTAssertEqual(firstCurrencyPair, expectedFirstPair)
        
        let secondCurrencyPair = userCurrencyPairs.selectedPairs[1]
        let expectedSecondPair = "\("GBP")\("EUR")"
        XCTAssertEqual(secondCurrencyPair, expectedSecondPair)
    }
    
    func test_addExistingCurrencyPair_fails() {
        var userCurrencyPairs = UserCurrencyPairs(selectedPairs: selectedCurrencyPairs)
        let currencyA = Currency(name: "British Pound", code: "GBP")
        let currencyB = Currency(name: "United States Dollar", code: "USD")
        userCurrencyPairs.addNewCurrencyPair(with: currencyA, currencyTwo: currencyB)
        
        // Check that an existing pari is not added 
        XCTAssertEqual(userCurrencyPairs.selectedPairs.count, 2)
    }
    
    func test_removeCurrencyPair() {
        let currencyPairs = ["USDGBP", "GBPUSD"]
        let pairToRemove = "USDGBP"
        var userCurrencyPairs = UserCurrencyPairs(selectedPairs: selectedCurrencyPairs)
        userCurrencyPairs.removeCurrencyPair(pairToRemove)
        
        XCTAssertEqual(userCurrencyPairs.selectedPairs.count, currencyPairs.count - 1)
        XCTAssertFalse(userCurrencyPairs.selectedPairs.contains(pairToRemove))
    }
    
    func test_fetchUrlSuffix() {
        var userCurrencyPairs = UserCurrencyPairs(selectedPairs: [])
        let currencyA = Currency(name: "British Pound", code: "GBP")
        let currencyB = Currency(name: "Euro", code: "EUR")
        
        userCurrencyPairs.addNewCurrencyPair(with: currencyA, currencyTwo: currencyB)
        
        let currencyC = Currency(name: "Danish Krone", code: "DKK")
        let currencyD = Currency(name: "Singapore Dollar", code: "SGD")
        userCurrencyPairs.addNewCurrencyPair(with: currencyC, currencyTwo: currencyD)
        
        let expectedSuffix = "?pairs=\(currencyC.code + currencyD.code)&pairs=\(currencyA.code + currencyB.code)"
        let urlSuffix = userCurrencyPairs.fetchUrlSuffix()
        XCTAssertEqual(urlSuffix, expectedSuffix)
    }
}

// MARK: - Test Fetch & Save UserCurrencyPairs
extension UserCurrencyPairsTests {
    func test_saveUserCurrencyPairs() {
        let userCurrencyPairs = UserCurrencyPairs(selectedPairs: selectedCurrencyPairs)
        userCurrencyPairs.saveSelectedPairs()
        
        let defaults = UserDefaults.standard
        let savedPairs = defaults.stringArray(forKey: "UserCurrencyPairs") ?? [String]()
        XCTAssertEqual(savedPairs, userCurrencyPairs.selectedPairs)
    }
    
    func test_fetchSavedCurrencyPairs_succeeds() {
        let userCurrencyPairs = UserCurrencyPairs(selectedPairs: selectedCurrencyPairs)
        userCurrencyPairs.saveSelectedPairs()
        
        let savedPairs = UserCurrencyPairs.fetchSavedSelectedCurrencyPairs()
        XCTAssertEqual(savedPairs, userCurrencyPairs.selectedPairs)
    }
    
    func test_fetchSavedCurrencyPairs_returnsNil() {
        let userCurrencyPairs = UserCurrencyPairs(selectedPairs: [])
        userCurrencyPairs.saveSelectedPairs()
         
        let savedPairs = UserCurrencyPairs.fetchSavedSelectedCurrencyPairs()
        XCTAssertEqual(savedPairs, [])
    }
}
