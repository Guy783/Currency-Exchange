//
//  CoordinatorTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 07/03/2020.
//

import XCTest
@testable import ExchangeRate

class CoordinatorTests: XCTestCase {

    private var mainCoordinator: TestCoordinator?
    
    override func setUp() {
        mainCoordinator = makeCoordinator()
    }

    override func tearDown() {
        mainCoordinator = nil
    }
}

// MARK: - Create Test Coordinator
extension CoordinatorTests {
    private func makeCoordinator() -> TestCoordinator {
        let navigationViewController = UINavigationController()
        let testRouter = Router(rootController: navigationViewController)
        return TestCoordinator(router: testRouter, coordinatorDelegate: nil)
    }
}

// MARK: - Update Tests
extension CoordinatorTests {
    func test_addChildCoordinator() {
        let coordinatorOne = makeCoordinator()
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorOne)
        
        let testCoordinator = mainCoordinator?.childCoordinators[0]
        
        XCTAssert(testCoordinator === coordinatorOne)
    }
    
    func test_removeChildCoordinator() {
        let coordinatorOne = makeCoordinator()
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorOne)
        
        mainCoordinator?.removeChildCoordinator(coordinator: coordinatorOne)
        
        XCTAssertEqual(mainCoordinator?.childCoordinators.count, 0)
    }
    
    func test_addChildCoordinator_onlyAddsOneChildCoordinator() {
        let coordinatorOne = makeCoordinator()
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorOne)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorOne)
        
        XCTAssertEqual(mainCoordinator?.childCoordinators.count, 1)
    }
    
    func test_removeChildCoordinator_onlyRemovesOneChildCoordinator() {
        let coordinatorOne = makeCoordinator()
        let coordinatorTwo = makeCoordinator()
        let coordinatorThree = makeCoordinator()
        let coordinatorFour = makeCoordinator()
        let coordinatorFive = makeCoordinator()
        
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorOne)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorTwo)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorThree)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorFour)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorFive)
        
        mainCoordinator?.removeChildCoordinator(coordinator: coordinatorFour)
        
        XCTAssertEqual(4, mainCoordinator?.childCoordinators.count)
    }
    
    func test_removeChildCoordinator_removeSameChildTwice() {
        let coordinatorOne = makeCoordinator()
        let coordinatorTwo = makeCoordinator()
        let coordinatorThree = makeCoordinator()
        let coordinatorFour = makeCoordinator()
        
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorOne)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorTwo)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorThree)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorFour)
        
        mainCoordinator?.removeChildCoordinator(coordinator: coordinatorThree)
        mainCoordinator?.removeChildCoordinator(coordinator: coordinatorThree)
        
        XCTAssertEqual(3, mainCoordinator?.childCoordinators.count)
    }
}

// MARK: - TestCoordinator
private class TestCoordinator: Coordinator {
    override func start() {}
}
