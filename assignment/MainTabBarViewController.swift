//
//  MainTabBarViewController.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit
import RxSwift

final class MainTabBarViewController: UITabBarController {
    fileprivate let disposeBag = DisposeBag()
    fileprivate let authService: AuthServiceType
    init(
        authService: AuthServiceType,
        searchRepoViewListViewController: SearchRepoListViewController,
        profileViewController: ProfilViewController
    ) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
        viewControllers = [searchRepoViewListViewController, profileViewController]
            .map { viewController -> UINavigationController in
                UINavigationController(rootViewController: viewController)
            }
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
