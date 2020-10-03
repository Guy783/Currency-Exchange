//
//  HTTPURLResponse+Extensions.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 21/03/2020.
//  Copyright © 2020 Takomborerwa. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    var isSuccessful: Bool {
        (200...299).contains(statusCode)
    }
    
    var errorString: String {
        HTTPURLResponse.localizedString(forStatusCode: statusCode)
    }
}
