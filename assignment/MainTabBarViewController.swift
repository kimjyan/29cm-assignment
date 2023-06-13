//
//  MainTabBarViewController.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    init(searchRepoViewListViewController: SearchRepoListViewController,
         profileViewController: ProfilViewController) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [searchRepoViewListViewController, profileViewController]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
