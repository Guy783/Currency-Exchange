//
//  GenericError.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 09/03/2020.
//

import Foundation

// MARK: - Generic
enum GenericError: Error {
    case withMessage(_ message: String)
}

// MARK: - Networking
enum FetchError: Error {
    case fetchFailed
    case unknownError
}

enum HTTPError: Error {
    case requestFailed(with: String)
}

enum URLComposingError: Error {
    case invalidURL(absoluteString: String)
}
