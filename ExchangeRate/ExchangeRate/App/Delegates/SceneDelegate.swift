//
//  SceneDelegate.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 07/03/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            fatalError("Window failed to initialise in SceneDelegate")
        }
        initializeMainCoordinator(with: windowScene)
    }
    
    func initializeMainCoordinator(with windowScene: UIWindowScene) {
        let appWindow = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let router = Router(rootController: navigationController)
        appWindow.rootViewController = router.rootController
        
        appCoordinator = AppCoordinator(router: router, coordinatorDelegate: nil)
        appCoordinator.start()
        
        self.window = appWindow
        self.window?.makeKeyAndVisible()
    }
}
