//
//  Routerable.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 17/03/2020.
//

import Foundation
import UIKit

protocol Routerable {
    func setRootViewController(viewController: UIViewController, hideBar: Bool, animated: Bool)
    func pushViewController(viewController: UIViewController, animated: Bool)
    func presentViewController(viewController: UIViewController, animated: Bool)
    func dismissViewController(animated: Bool)
    func popViewController(animated: Bool)
}
