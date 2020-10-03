//
//  NSObject+ExtensionsTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 14/03/2020.
//

import XCTest
@testable import ExchangeRate

class NSObject_ExtensionsTests: XCTestCase {
    func test_classNameClassVar() {
        XCTAssertEqual(UIViewController.className, "UIViewController")
    }
    
    func test_classNameVar() {
        let viewController = UIViewController()
        XCTAssertEqual(viewController.className, "UIViewController")
    }
}
