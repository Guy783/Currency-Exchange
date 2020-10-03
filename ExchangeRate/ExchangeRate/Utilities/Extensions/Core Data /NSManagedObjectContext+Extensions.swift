//
//  NSManagedObjectContext+Extensions.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 08/03/2020.
//

import CoreData

/// We want NSManagedObjectContext to conform to Context so that it can easily use CoreDataManager's
/// methods such as save 
extension NSManagedObjectContext: Contextable {
    /// Creates child context  (EditingContext),  separate from the current context
    /// When the parent context is saved and changed, the changes from the parent are merged into the child
    /// When used with CoreDataManager, changes made to this child context, will be merged into the parent
    func newEditingContext() -> Contextable {
       let editingContext = NSManagedObjectContext(concurrencyType: concurrencyType)
       CoreDataManager.shared.editingContexts.insert(editingContext)
       editingContext.parent = self
       editingContext.automaticallyMergesChangesFromParent = true
       return editingContext
    }
    
    /// Saves the passed in context
    /// - Parameter completion: completion
    func save(_ completion: VoidHandler?) {
        CoreDataManager.shared.save(context: self) {
            completion?()
        }
    }
    
    /// Saves the current context (most likely an editing context) then
    /// saves  CoreDataManager.mainContext
    /// - Parameter completion: completion
    func saveToDisc(_ completion: VoidHandler? = nil) {
        CoreDataManager.shared.save(context: self) {
            CoreDataManager.shared.saveMainContext(completion)
        }
    }
    
    /// Resets the current contextto it's base state and removes subsequent child contexts
    func dismiss() {
        reset()
        CoreDataManager.shared.editingContexts.remove(self)
    }
    
    /// Refreshes all currently registered objects that are associated with this context.
    func refresh() {
        refreshAllObjects()
    }
}
