//
//  CurrencyDB+Extensions.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 07/03/2020.
//

import CoreData

// MARK: - Create & Update
extension CurrencyDB {
    class func create(with currency: Currency, in context: NSManagedObjectContext) -> CurrencyDB {
        var currencyDB: CurrencyDB
        if let existingCurrencyDB = fetchCurrency(with: currency.id, in: context) {
            currencyDB = existingCurrencyDB
        } else {
            currencyDB = CurrencyDB(context: context)
        }
        currencyDB.update(with: currency, in: context)
        return currencyDB
    }
    
    func update(with currency: Currency, in context: NSManagedObjectContext) {
        self.id = currency.id
        self.name = currency.name
        self.code = currency.code
    }
}

// MARK: - Fetch
extension CurrencyDB {
    class func fetchCurrencies(in context: NSManagedObjectContext) -> [CurrencyDB] {
        let request: NSFetchRequest<CurrencyDB> = CurrencyDB.fetchRequest()
        return CoreDataManager.shared.fetch(request, in: context) ?? []
    }
    
    class func fetchCurrency(with currencyID: String, in context: NSManagedObjectContext = CoreDataManager.shared.mainContext) -> CurrencyDB? {
        let request: NSFetchRequest<CurrencyDB> = CurrencyDB.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id = %@", currencyID)
        return CoreDataManager.shared.fetch(request, in: context)?.first
    }
}

// MARK: - Delete
extension CurrencyDB {
    func delete() {
        CoreDataManager.shared.delete(self)
    }
}
