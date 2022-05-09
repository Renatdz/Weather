//
//  AppDelegate.swift
//  Weather
//
//  Created by RENATO DOS SANTOS MENDES on 08/05/22.
//

import UIKit

@main
final class AppDelegate: UIResponder {
    var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let rootController = ListFactory.make()
        let navigationController = UINavigationController(rootViewController: rootController)
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
        
        return true
    }
}
