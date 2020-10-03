//
//  CurrencyPairsService.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 22/03/2020.
//  Copyright © 2020 Takomborerwa. All rights reserved.
//

import Foundation

class CurrencyPairsService: NetworkService {
    static func fetchCurrencyPairs(with currencyPairsUrlSuffix: String, _ completion: @escaping NetworkServiceCompletionHandler) {
        do {
            let itemRequest = try URLRequestCollection.currenciesRequest(with: currencyPairsUrlSuffix)
            client.executeRequest(itemRequest) { [] result in
                switch result {
                case .success(let data):
                    do {
                        let currencyPairsDict = try JSONDecoder().decode([String: Double].self, from: data)
                        var currencyPairs = [CurrencyPair]()
                        for keyValuePair in currencyPairsDict {
                            let currencyPairAndRate = CurrencyPairAndRate(currenyCodes: keyValuePair.key, exchangeRate: keyValuePair.value )
                            let currencyPair = CurrencyPair(with: currencyPairAndRate)
                            currencyPairs.append(currencyPair)
                        }
                        completion(currencyPairs, nil)
                    } catch {
                        completion(nil, error)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        } catch {
            completion(nil, error)
        }
    }
}
