//
//  MockDataRequest.swift
//  ExchangeRateTests
//
//  Created by Takomborerwa Mazarura on 09/03/2020.
//

import Foundation

enum LocalMockURLRequestCollection: String {
    case currencies
    case currencyPairs
    
    var fileName: String {
        switch self {
        case .currencies:
            return "MockCurrenciesResponse"
        case .currencyPairs:
            return "MockCurrencyPairsResponse"
        }
    }
}
