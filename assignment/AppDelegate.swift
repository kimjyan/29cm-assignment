//
//  AppDelegate.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit
import URLNavigator

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    fileprivate let navigator = Navigator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let authService = AuthService(navigator: navigator)
        URLNavigatorMap.initialize(navigator: navigator, authService: authService)
        window = {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = MainTabBarViewController(
                authService: authService,
                searchRepoViewListViewController: SearchRepoListViewController(authService: authService),
                profileViewController: ProfilViewController()
            )
            window.makeKeyAndVisible()
            return window
        }()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if navigator.open(url) {
            return true
        }
        if navigator.present(url, wrap: UINavigationController.self) != nil {
            return true
        }
        return false
    }
}

