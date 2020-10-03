//
//  URLRequestCollectionTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import XCTest
@testable import ExchangeRate

class URLRequestCollectionTests: XCTestCase {}

// MARK: - URLRequestCollectionTests Utilities
extension URLRequestCollectionTests {
    func test_composeURL_throwsError () {
        let urlString = "1|-2**6"
        do {
            _ = try URLRequestCollection.composeURL(with: urlString)
            XCTFail("Request was created with an illegal URL")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

// MARK: - Currencies Request Tests
extension URLRequestCollectionTests {
    func test_createCurrenciesRequest() {
        let urlPairs = "?pairs=USDGBP&pairs=GBPUSD"
        do {
            let request = try URLRequestCollection.currenciesRequest(with: urlPairs)
            XCTAssertEqual(request.url?.absoluteURL.absoluteString, URLRequestCollection.baseURL + urlPairs)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_createCurrenciesRequest_fails_withEmptyPairs() {
        let urlPairs = ""
        do {
            _ = try URLRequestCollection.currenciesRequest(with: urlPairs)
            XCTFail("Request was created with empty URL pairs")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
