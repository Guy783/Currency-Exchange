//
//  ViewModelableTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import XCTest
@testable import ExchangeRate

class ViewModelableTests: XCTestCase {}

// MARK: - Initialisation Tests
extension ViewModelableTests {
    func test_initialisation() {
        let fieldA = Field(title: "Field Title", detail: "Field Detail")
        let fields = [fieldA]
        
        let sectionA = SectionItem(title: "Section A", fields: fields)
        let sections = [sectionA]
    
        let testViewModel = TestViewModel(with: sections)
        XCTAssertEqual(testViewModel.numberOfSections(), sections.count)
        XCTAssertEqual(testViewModel.numberOfItems(in: 0), sections.count)
    }
    
    func test_updateWithNewSection() {
        let fieldA = Field(title: "Field Title", detail: "Field Detail")
        let sectionA = SectionItem(title: "Section A", fields: [fieldA])
        let sectionsA = [sectionA]
        
        var testViewModel = TestViewModel(with: sectionsA)
        
        let fieldB = Field(title: "Field Title", detail: "Field Detail")
        let sectionB = SectionItem(title: "Section A", fields: [fieldA, fieldB])
        let sectionsB = [sectionA, sectionB]
        
        testViewModel.update(with: sectionsB)
        let indexPath = IndexPath(item: 2, section: 1)
        
        XCTAssertEqual(testViewModel.numberOfSections(), sectionsB.count)
        XCTAssertEqual(testViewModel.numberOfItems(in: 0), sectionsA.count)
        XCTAssertEqual(testViewModel.numberOfItems(in: 1), sectionsB.count)
        
        guard let firstField = testViewModel.item(for: indexPath) as? Field else {
            return
        }
        XCTAssertEqual(firstField.id, fieldB.id)
    }
    
    func test_itemForIndexPath_returnsCorrectItem() {
        let fieldA = Field(title: "Field Title", detail: "Field Detail")
        let fields = [fieldA]
        
        let sectionA = SectionItem(title: "Section A", fields: fields)
        let sections = [sectionA]
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        
        let testViewModel = TestViewModel(with: sections)
        guard let firstField = testViewModel.item(for: firstIndexPath) as? Field else {
            return
        }
        XCTAssertEqual(firstField.id, fieldA.id)
    }
    
    func test_itemForIndexPath_returnsNil() {
        let fieldA = Field(title: "Field Title", detail: "Field Detail")
        let fields = [fieldA]
        
        let sectionA = SectionItem(title: "Section A", fields: fields)
        let sections = [sectionA]
        
        let firstIndexPath = IndexPath(item: sections.count + 1, section: 0)
        
        let testViewModel = TestViewModel(with: sections)
        XCTAssertNil(testViewModel.item(for: firstIndexPath))
    }
}

// MARK: - TestViewModel
private class TestViewModel: ViewModelable {
    var sections: [SectionItem]
    
    init(with sections: [SectionItem]) {
        self.sections = sections
    }
}
