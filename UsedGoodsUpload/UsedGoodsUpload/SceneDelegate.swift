//
//  SceneDelegate.swift
//  UsedGoodsUpload
//
//  Created by 전성규 on 2023/02/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let rootViewModel = MainViewModel()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let rootViewController = MainViewController()
        rootViewController.bind(rootViewModel)
 
        self.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        self.window?.makeKeyAndVisible()
    }
}

