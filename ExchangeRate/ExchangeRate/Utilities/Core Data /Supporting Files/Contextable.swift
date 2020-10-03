//
//  Context.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 08/03/2020.
//

typealias VoidHandler = () -> Void

protocol Contextable {
    var hasChanges: Bool { get }
    
    func newEditingContext() -> Contextable
    func save(_ completion: VoidHandler?)
    func saveToDisc(_ completion: VoidHandler?)
    func dismiss()
    func refresh()
}
