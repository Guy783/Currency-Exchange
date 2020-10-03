//
//  Currency.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 07/03/2020.
//

import CoreData
import UIKit

struct Currency: Codable {
    var id: String
    var name: String
    var code: String
    
    var nameAndCode: String {
        return "\(name) ∙ \(code)"
    }
    
    init(with id: String = UUID().uuidString, name: String, code: String) {
        self.id = id
        self.name = name
        self.code = code
    }
    
    init(_ currencyDB: CurrencyDB) {
        self.id = currencyDB.id ?? UUID().uuidString
        self.name = currencyDB.name ?? ""
        self.code = currencyDB.code ?? ""
    }
}

// MARK: - Service Calls
extension Currency {
    static func fetchCurrencies(_ completion: @escaping NetworkServiceCompletionHandler) {
        CurrenciesService.fetchAllCurrencies { result, error in
            if let requestError = error {
                completion(nil, requestError)
            } else {
                guard let currencies = result as? [Currency] else {
                    completion(nil, FetchError.fetchFailed)
                    return
                }
                completion(currencies, nil)
            }
        }
    }
    
    static func fetchCurrenciesPairs(with currencyPairsUrlSuffix: String, _ completion: @escaping NetworkServiceCompletionHandler) {
        CurrencyPairsService.fetchCurrencyPairs(with: currencyPairsUrlSuffix, { result, error in
            if let requestError = error {
                completion(nil, requestError)
            } else {
                guard let currencyPairs = result as? [CurrencyPair] else {
                    completion(nil, FetchError.fetchFailed)
                    return
                }
                completion(currencyPairs, nil)
            }
        })
    }
    
    static func fetchCurrency(with code: String, from currencies: [Currency]) -> Currency? {
        if let currency = currencies.first(where: { $0.code == code }) {
            return currency
        }
        return nil
    }
}
