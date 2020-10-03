//
//  NetworkService.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 09/03/2020.
//

import Foundation

protocol NetworkServiceable {
    static var client: Client { get }
}

typealias NetworkServiceCompletionHandler = (_ result: Any?, _ error: Error?) -> Void

class NetworkService: NetworkServiceable {
    static var client = Client()
}
