//
//  AppDelegate.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = MainTabBarViewController(
                searchRepoViewListViewController: SearchRepoListViewController(),
                profileViewController: ProfilViewController()
            )
            window.makeKeyAndVisible()
            return window
        }()
        
        return true
    }
}

