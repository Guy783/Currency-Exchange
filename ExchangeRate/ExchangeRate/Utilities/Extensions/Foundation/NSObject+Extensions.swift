//
//  NSObject+Extensions.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 08/03/2020.
//

import Foundation

extension NSObject {
    var className: String {
        return "\(type(of: self))"
    }
    
    class var className: String {
        return "\(self)"
    }
}
