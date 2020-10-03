//
//  ViewModellabel.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import Foundation

protocol ViewModelable {
    var sections: [SectionItem] { get set }
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(for indexPath: IndexPath) -> Any?
    mutating func update(with newSections: [SectionItem])
}

extension ViewModelable {
    mutating func update(with newSections: [SectionItem]) {
        sections = newSections
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        return sections[section].fields.count
    }
    
    func item(for indexPath: IndexPath) -> Any? {
        guard sections.indices.contains(indexPath.section), sections[indexPath.section].fields.indices.contains(indexPath.row) else {
            return nil
        }
        return sections[indexPath.section].fields[indexPath.row]
    }
}
