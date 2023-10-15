//
//  SceneDelegate.swift
//  PetLanguage
//
//  Created by minsong kim on 10/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let firstViewController = PetInformationViewController()
        let navigationViewController = UINavigationController(rootViewController: firstViewController)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}

