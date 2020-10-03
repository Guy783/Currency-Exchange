//
//  Storyboarded.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import UIKit

protocol Storyboarded {
    var coordinator: Coordinator? { get set }
    
    static func instantiate(with storyboardName: String) -> Self
    func makeAccessible()
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(with storyboardName: String) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Could not create View Controller with name \(className) from storyboard \(storyboardName)")
        }
        return viewController
    }
}
