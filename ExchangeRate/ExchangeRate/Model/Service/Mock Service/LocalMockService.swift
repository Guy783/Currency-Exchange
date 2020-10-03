//
//  MockServer.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 09/03/2020.
//

import Foundation

final class LocalMockService {
    static func fetchData(for request: LocalMockURLRequestCollection) -> Data? {
        let bundle = Bundle(for: LocalMockService.self)
        if let filePath = bundle.path(forResource: request.fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: filePath)
                return try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            } catch {
                fatalError("Could not collect data from MockJSON")
            }
        }
        fatalError("Could find MockJSON in Bundle")
    }
    
    static func fetchLocalCurrencyPairs(with currencyPairsUrlSuffix: String, _ completion: @escaping NetworkServiceCompletionHandler) {
        guard let data = LocalMockService.fetchData(for: .currencyPairs) else {
            completion(nil, FetchError.fetchFailed)
            return
        }
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
            completion(nil, FetchError.fetchFailed)
        }
    }
}
