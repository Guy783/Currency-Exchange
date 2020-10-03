//
//  BaseViewController.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import os
import UIKit

class BaseViewController: UIViewController, Storyboarded {
    var coordinator: Coordinator?
    
    // MARK: - Setup Navigation Bar
    func setupNavigationBar(isHidden: Bool = true) {
        navigationController?.setNavigationBarHidden(isHidden, animated: false)
    }
    
    // MARK: - Make Accessible (Override)
    func makeAccessible() {}
}

// MARK: Alerts
extension BaseViewController {
    func alertController(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction]) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alertController.addAction(action)
        }
        return alertController
    }
    
    func presentOkAlert(title: String? = R.string.localised.errorTitle(), message: String?, alertTitle: String? = R.string.localised.ok()) {
        let okAction = UIAlertAction(title: alertTitle, style: .default, handler: nil)
        presentAlertController(title: title, message: message, style: .alert, actions: [okAction], completion: nil)
    }
    
    func presentAlertController(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction], completion: (() -> Void)?) {
        let alertController = self.alertController(title: title, message: message, style: style, actions: actions)
        DispatchQueue.main.async {
            self.coordinator?.router.presentViewController(viewController: alertController, animated: true)
        }
    }
}
