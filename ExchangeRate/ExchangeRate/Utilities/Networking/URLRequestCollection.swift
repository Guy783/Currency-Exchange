//
//  URLRequestPool.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 09/03/2020.
//

import Foundation

struct URLRequestCollection {
    static let baseURL = "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios"
    
    static func composeURL(with urlEndPoint: String) throws -> URL {
        let urlString = baseURL + urlEndPoint
        guard let url = URL(string: urlString) else {
            throw URLComposingError.invalidURL(absoluteString: urlString)
        }
        return url
    }
}

extension URLRequestCollection {
    static func currenciesRequest(with currencyPairsUrlSuffix: String) throws -> URLRequest {
        if currencyPairsUrlSuffix.isEmpty {
            throw URLComposingError.invalidURL(absoluteString: "No currency pairs for url request")
        }
        let urlEndPoint = currencyPairsUrlSuffix
        let url = try URLRequestCollection.composeURL(with: urlEndPoint)
        return URLRequest(url: url)
    }
}
