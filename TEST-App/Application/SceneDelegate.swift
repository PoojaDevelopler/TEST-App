//
//  SceneDelegate.swift
//  TEST-App
//
//  Created by pnkbksh on 14/04/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene{
            let window = UIWindow(windowScene: windowScene)
            navigationController = UINavigationController()
            navigationController = UINavigationController(
                rootViewController: HomeView()
            )
            
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
}

