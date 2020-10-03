//
//  DataTaskable.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 09/03/2020.
//

import Foundation

typealias DataTaskCompletionHandler = (Data?, URLResponse?, Error?) -> Void

protocol DataTaskable {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask
}

extension URLSession: DataTaskable {}
