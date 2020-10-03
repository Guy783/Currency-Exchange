//
//  HTTPURLResponse+ExtensionsTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 21/03/2020.
//  Copyright © 2020 Takomborerwa. All rights reserved.
//

import UIKit
import XCTest

@testable import ExchangeRate

class HTTPURLResponseExtensionsTests: XCTestCase {
    func test_response_isSuccessfull() {
        let headerFields = ["fieldOne" : "12345678"]
        guard let url = URL(string: "https://europe-west1-revolut-230009.cloudfunctions.net/") else {
            return XCTFail("Could not create URL for response")
        }
        let responseOne = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: headerFields)
        let responseTwo = HTTPURLResponse(url: url, statusCode: 299, httpVersion: "HTTP/1.1", headerFields: headerFields)
        let responseThree = HTTPURLResponse(url: url, statusCode: 250, httpVersion: "HTTP/1.1", headerFields: headerFields)
        
        XCTAssertTrue(responseOne?.isSuccessful ?? false)
        XCTAssertTrue(responseTwo?.isSuccessful ?? false)
        XCTAssertTrue(responseThree?.isSuccessful ?? false)
    }
    
    func test_response_fails() {
        let headerFields = ["fieldOne" : "12345678"]
        guard let url = URL(string: "https://europe-west1-revolut-230009.cloudfunctions.net/") else {
            return XCTFail("Could not create URL for response")
        }
        let responseOne = HTTPURLResponse(url: url, statusCode: 100, httpVersion: "HTTP/1.1", headerFields: headerFields)
        let responseTwo = HTTPURLResponse(url: url, statusCode: 400, httpVersion: "HTTP/1.1", headerFields: headerFields)
        let responseThree = HTTPURLResponse(url: url, statusCode: 500, httpVersion: "HTTP/1.1", headerFields: headerFields)
        
        XCTAssertTrue(responseOne?.isSuccessful ?? false == false)
        XCTAssertTrue(responseTwo?.isSuccessful ?? false == false)
        XCTAssertTrue(responseThree?.isSuccessful ?? false == false)
    }
    
    
    func test_responseErrorString() {
        let headerFields = ["fieldOne" : "12345678"]
        guard let url = URL(string: "https://europe-west1-revolut-230009.cloudfunctions.net/") else {
            return XCTFail("Could not create URL for response")
        }
        guard let responseOne = HTTPURLResponse(url: url, statusCode: 100, httpVersion: "HTTP/1.1", headerFields: headerFields) else {
            return XCTFail("Could not create HTTPURLResponse")
        }
        guard let responseTwo = HTTPURLResponse(url: url, statusCode: 210, httpVersion: "HTTP/1.1", headerFields: headerFields) else {
            return XCTFail("Could not create HTTPURLResponse")
        }
        guard let responseThree = HTTPURLResponse(url: url, statusCode: 400, httpVersion: "HTTP/1.1", headerFields: headerFields) else {
            return XCTFail("Could not create HTTPURLResponse")
        }
        
        XCTAssertEqual(responseOne.errorString, "continue")
        XCTAssertEqual(responseTwo.errorString, "success")
        XCTAssertEqual(responseThree.errorString, "bad request")
    }
}
