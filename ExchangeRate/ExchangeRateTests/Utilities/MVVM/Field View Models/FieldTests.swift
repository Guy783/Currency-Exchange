//
//  FieldTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 12/03/2020.
//

import XCTest
@testable import ExchangeRate

class FieldTests: XCTestCase {}

// MARK: - Initialisation Tests
extension FieldTests {
    func test_initialisation_withID() {
        let id = "1"
        let title = "Field Title"
        let detail = "Field Detail"
        let fieldA = Field(with: id, title: title, detail: detail)
        
        XCTAssertEqual(fieldA.id, id)
        XCTAssertEqual(fieldA.title, title)
        XCTAssertEqual(fieldA.detail, detail)
    }
    
    func test_initialisation_without() {
        let title = "Field Title"
        let detail = "Field Detail"
        let fieldA = Field(title: title, detail: detail)
        
        XCTAssertNotNil(fieldA.id)
        XCTAssertEqual(fieldA.title, title)
        XCTAssertEqual(fieldA.detail, detail)
    }
}
