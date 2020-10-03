//
//  BaseViewModelTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import XCTest
@testable import ExchangeRate

class BaseViewModelTests: XCTestCase {}

// MARK: - Initialisation Tests
extension BaseViewModelTests {
    func test_initialisation() {
        let fieldA = Field(title: "Field Title", detail: "Field Detail")
        let fields = [fieldA]
        
        let sectionA = SectionItem(title: "Section A", fields: fields)
        let sections = [sectionA]
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        
        let baseViewModel = BaseViewModel(with: sections)
        XCTAssertEqual(baseViewModel.numberOfSections(), sections.count)
        XCTAssertEqual(baseViewModel.numberOfItems(in: 0), sections.count)
        guard let firstField = baseViewModel.item(for: firstIndexPath) as? Field else {
            return
        }
        XCTAssertEqual(firstField.id, fieldA.id)
        
    }
}
