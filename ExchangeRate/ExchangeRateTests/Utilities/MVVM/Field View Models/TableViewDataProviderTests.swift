//
//  TableViewDataProviderTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 21/03/2020.
//  Copyright © 2020 Takomborerwa. All rights reserved.
//

import UIKit

import XCTest
@testable import ExchangeRate

class TableViewDataProviderTests: XCTest {
    private var tableView: UITableView!
    private var testViewModel: BaseViewModel!
    private var testViewController: TestViewController!
    
    override func setUp() {
        super.setUp()
        let fieldA = Field(title: "FieldA", detail: "FieldA Detail")
        let fieldB = Field(title: "FieldB", detail: "FieldB Detail")
        let fieldC = Field(title: "FieldC", detail: "FieldC Detail")
        let sectionAFields = [fieldA, fieldB, fieldC]
        
        let fieldD = Field(title: "FieldD", detail: "FieldD Detail")
        let fieldE = Field(title: "FieldE", detail: "FieldE Detail")
        let fieldF = Field(title: "FieldF", detail: "FieldF Detail")
        let sectionBFields = [fieldD, fieldE, fieldF]
        
        let sectionItemA = SectionItem(title: "Section A", fields: sectionAFields)
        let sectionItemB = SectionItem(title: "Section B", fields: sectionBFields)
        
        tableView = UITableView()
        testViewModel = BaseViewModel(with: [sectionItemA, sectionItemB])
        testViewController = TestViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        testViewModel = nil
        testViewController = nil
    }
}

// MARK: - Init tests
extension TableViewDataProviderTests {
    func test_init_withDelegate() {
        let tableViewDataProvider = TableViewDataProvider(with: tableView, viewModel: testViewModel, delegate: testViewController)
        XCTAssertEqual(tableViewDataProvider.tableView, tableView)
        
        XCTAssertNotNil(tableViewDataProvider.viewModel)
        XCTAssertTrue(tableViewDataProvider.viewModel is BaseViewModel)
        
        XCTAssertNotNil(tableViewDataProvider.delegate)
        XCTAssertTrue(tableViewDataProvider.delegate is BaseViewModel)
    }
    
    func test_init_withoutDelegate() {
        let tableViewDataProvider = TableViewDataProvider(with: tableView, viewModel: testViewModel, delegate: testViewController)
        XCTAssertEqual(tableViewDataProvider.tableView, tableView)
        
        XCTAssertNotNil(tableViewDataProvider.viewModel)
        XCTAssertTrue(tableViewDataProvider.viewModel is BaseViewModel)
        
        XCTAssertNil(tableViewDataProvider.delegate)
    }
}

// MARK: - Update tests
extension TableViewDataProviderTests {
    func test_insertCell() {
        let tableViewDataProvider = TableViewDataProvider(with: tableView, viewModel: testViewModel, delegate: testViewController)
        
        let fieldA = Field(title: "FieldA", detail: "FieldA Detail")
        let fieldB = Field(title: "FieldB", detail: "FieldB Detail")
        let fieldC = Field(title: "FieldC", detail: "FieldC Detail")
        let fieldX = Field(title: "FieldX", detail: "FieldX Detail") // New Field
        let sectionAFields = [fieldA, fieldB, fieldC, fieldX]
        
        let fieldD = Field(title: "FieldD", detail: "FieldD Detail")
        let fieldE = Field(title: "FieldE", detail: "FieldE Detail")
        let fieldF = Field(title: "FieldF", detail: "FieldF Detail")
        let sectionBFields = [fieldD, fieldE, fieldF]
        
        let sectionItemA = SectionItem(title: "Section A", fields: sectionAFields)
        let sectionItemB = SectionItem(title: "Section B", fields: sectionBFields)
        
        let updatedViewModel = BaseViewModel(with: [sectionItemA, sectionItemB])
        tableViewDataProvider.viewModel = updatedViewModel
        tableViewDataProvider.insertNewRows(at: [IndexPath(item: 3, section: 1)], with: .none)
        XCTAssertEqual(tableViewDataProvider.tableView.numberOfRows(inSection: 0), 4)
    }
}

// MARK: - Fetch Tests
extension TableViewDataProviderTests {
    func test_numberOfSections() {
        let tableViewDataProvider = TableViewDataProvider(with: tableView, viewModel: testViewModel, delegate: testViewController)
        XCTAssertEqual(tableViewDataProvider.numberOfSections(in: tableView), testViewModel.numberOfSections())
    }
    
    func test_numberOfRowsInSection() {
        let tableViewDataProvider = TableViewDataProvider(with: tableView, viewModel: testViewModel, delegate: testViewController)
        let sectionAIndex = 0
        let sectionBIndex = 1
        XCTAssertEqual(tableViewDataProvider.tableView(tableView, numberOfRowsInSection: sectionAIndex), testViewModel.numberOfItems(in: sectionAIndex))
        XCTAssertEqual(tableViewDataProvider.tableView(tableView, numberOfRowsInSection: sectionAIndex), testViewModel.numberOfItems(in: sectionBIndex))
    }
    
    func test_cellForRow() {
        let tableViewDataProvider = TableViewDataProvider(with: tableView, viewModel: testViewModel, delegate: testViewController)
        let indexPath = IndexPath(row: 0, section: 0)
        guard let expectedField = testViewModel.item(for: indexPath) as? Field else {
            return XCTFail("TestViewModel did not return Field")
        }
        
        let returnedCell = tableViewDataProvider.tableView(tableView, cellForRowAt: indexPath)
        XCTAssertEqual(returnedCell.className, UITableViewCell.className)
        XCTAssertEqual(returnedCell.textLabel?.text, expectedField.title)
        XCTAssertEqual(returnedCell.detailTextLabel?.text, expectedField.detail)
    }
    
    func test_didSelectRow() {
        let tableViewDataProvider = TableViewDataProvider(with: tableView, viewModel: testViewModel, delegate: testViewController)
        let indexPath = IndexPath(row: 0, section: 0)
        tableViewDataProvider.tableView(tableView, didSelectRowAt: indexPath)
        
        XCTAssertTrue(testViewController.didSelectField)
    }
}

class TestViewController: UIViewController, DataProviderDelegate {
    var didReloadData = false
    var didSelectField = false
    
    func reloadData() {
        didReloadData = true
    }
    
    func didSelect(_ field: Field) {
        didSelectField = true
    }
}
