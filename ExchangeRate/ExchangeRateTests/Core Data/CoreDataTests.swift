//
//  CoreDataTests.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 08/03/2020.
//

import XCTest
import CoreData

@testable import ExchangeRate

class CoreDataTests: XCTestCase {

    var coreDataManager: CoreDataManager!
    var persistentStore: NSPersistentStore!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager.shared
        do {
            managedObjectContext = try setupManagedObjectContextInMemory()
        } catch {
            XCTFail("")
        }
        coreDataManager.mainContext = managedObjectContext
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        persistentStore = nil
        managedObjectContext = nil
    }
    
    func setupManagedObjectContextInMemory() throws -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            throw GenericError.withMessage("Could not add persistent store into memory")
        }
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjectContext
    }
}
