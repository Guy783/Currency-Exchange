//
//  BaseViewModel.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import UIKit

class BaseViewModel: ViewModelable {
    var sections: [SectionItem]
    
    init(with sections: [SectionItem]) {
        self.sections = sections
    }
}
