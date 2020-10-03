//
//  Client.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 09/03/2020.
//

import Foundation

final class Client {
    lazy var session: DataTaskable = URLSession.shared
    
    func executeRequest(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(FetchError.fetchFailed))
                return
            }
            
            if let response = response as? HTTPURLResponse, !response.isSuccessful {
                completion(.failure(HTTPError.requestFailed(with: response.errorString)))
                return
            }
            
            if let data = data {
                completion(.success(data))
                return
            } else {
                completion(.failure(FetchError.unknownError))
                return
            }
        }.resume()
    }
}
