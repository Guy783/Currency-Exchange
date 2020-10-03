//
//  CoreDataManager.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 08/03/2020.
//

import CoreData
import os

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private var backgroundContexts = Set<NSManagedObjectContext>()
    private var _editingContext: NSManagedObjectContext?
    
    var editingContexts = Set<NSManagedObjectContext>()
    var editingContext: NSManagedObjectContext {
        if let context = _editingContext {
            return context
        } else {
            let newContext = newEditingContext() as! NSManagedObjectContext
            _editingContext = newContext
            return newContext
        }
    }
    var hasEditingChanges: Bool {
        return editingContext.hasChanges == true
    }
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        return context
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExchangeRate")
        container.loadPersistentStores(completionHandler: { (_ storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    // MARK: - Initalise
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(managedObjectContextDidSave),
                                               name: NSNotification.Name.NSManagedObjectContextDidSave,
                                               object: nil)
    }
}

// MARK: - Editing Context
extension CoreDataManager {
    func newEditingContext() -> Contextable {
        return mainContext.newEditingContext()
    }
    
    func resetEditingChanges() {
        _editingContext = nil
    }
}

// MARK: - Save Functions
extension CoreDataManager {
    func saveMainContext (_ completion: VoidHandler? = nil) {
        save(context: mainContext, completion: completion)
    }
    
    func saveEditingChanges(completion: VoidHandler? = nil) {
        save(context: editingContext, completion: {
            self.saveMainContext(completion) // TODO: - test if this is needed
        })
        resetEditingChanges()
    }
    
    /// Commits unsaved changes to registered objects to the context’s parent store
    /// The parent store can be a persistent store or another ManagedObjectContext
    func save(context: NSManagedObjectContext, completion: VoidHandler? = nil) {
        context.performAndWait {
            if context.hasChanges {
                do {
                    try context.save()
                    completion?()
                } catch {
                    let nserror = error as NSError
                    let log = ("Unresolved error \(nserror), \(nserror.userInfo)")
                    os_log(("Failed to save managed objects error: %@"), String(describing: log))
                    completion?()
                }
            } else {
                completion?()
            }
        }
    }
    
    /// Merges changes made from  i.e. an EditingContext to the CoreDataManager.mainContext if needed
    ///
    /// Method checks if the ManagedObjectContext received has the same PersistentStoreCoordinator as this CoreDataManager. If so this method will
    /// merge changes to the other Context into this CoreDataManager.maincontext. That way it's objects, in CoreDataManager.mainContext are in sync with the it's persistance store
    ///
    /// - Parameter notification: Contans the ManagedObjectContext just saved
    @objc
    func managedObjectContextDidSave(notification: NSNotification) {
        guard let context = notification.object as? NSManagedObjectContext else {
            return
        }
        if context.persistentStoreCoordinator == persistentContainer.persistentStoreCoordinator &&
            context.concurrencyType == .privateQueueConcurrencyType {
            mainContext.performAndWait {
                self.mainContext.mergeChanges(fromContextDidSave: notification as Notification)
            }
        }
    }
}

// MARK: - Fetch Functions
extension CoreDataManager {
    func fetch<T: NSManagedObject>(_ fetchRequest: NSFetchRequest<T>, in context: NSManagedObjectContext) -> [T]? {
        var results: [T]?
        context.performAndWait {
            do {
                results = try context.fetch(fetchRequest)
            } catch {
                os_log(("Failed to fetch managed objects error: %@"), String(describing: error))
            }
        }
        return results
    }
}

// MARK: - Delete Functions
extension CoreDataManager {
    func delete(_ managedObject: NSManagedObject) {
        guard let context = managedObject.managedObjectContext else {
            return
        }
        context.delete(managedObject)
        try? context.save()
    }
    
    func deleteAllObjects(for dbObjectClassName: String) {
        let dbFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: dbObjectClassName)
        let dbDeleteRequest = NSBatchDeleteRequest(fetchRequest: dbFetchRequest)
        do {
            try persistentContainer.persistentStoreCoordinator.execute(dbDeleteRequest, with: mainContext)
        } catch {
            os_log(("Failed to delete all managed objects with error: %@"), String(describing: error))
        }
    }
    
    func deleteAllManagedObjects() {
        let currencyDBFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CurrencyDB.className)
        let currencyDBDeleteRequest = NSBatchDeleteRequest(fetchRequest: currencyDBFetchRequest)
        do {
            try persistentContainer.persistentStoreCoordinator.execute(currencyDBDeleteRequest, with: mainContext)
        } catch {
            os_log(("Failed to delete all managed objects with error: %@"), String(describing: error))
        }
    }
}

// MARK: - Background Functions
extension CoreDataManager {
    func performBackgroundTask(block: @escaping (NSManagedObjectContext) -> Void) {
        saveMainContext {
            let context = self.newBackgroundContext()
            context.performAndWait {
                self.backgroundContexts.insert(context)
                block(context)
                self.backgroundContexts.remove(context)
            }
        }
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        context.automaticallyMergesChangesFromParent = true
        return context
    }
}
