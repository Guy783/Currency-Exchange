//
//  CurrenciesService.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 09/03/2020.
//

import Foundation

class CurrenciesService: NetworkService {
    static func fetchAllCurrencies(_ completion: @escaping NetworkServiceCompletionHandler) {
        guard let data = LocalMockService.fetchData(for: .currencies) else {
            completion(nil, FetchError.fetchFailed)
            return
        }
        do {
            let currencies = try JSONDecoder().decode([Currency].self, from: data)
            completion(currencies, nil)
        } catch {
            completion(nil, FetchError.fetchFailed)
        }
    }
}
