//
//  MainTabBarViewController.swift
//  assignment
//
//  Created by 쎄부킴 on 2023/06/14.
//

import UIKit
import RxSwift
import CoreNetwork
import CoreContainer
import GitHubSearch
import GitHubProfile

public final class MainTabBarViewController: UITabBarController {
    private let disposeBag = DisposeBag()
    private let authService = coreContainer.resolve(AuthServiceType.self)!
    
    public init() {
        super.init(nibName: nil, bundle: nil)

        let viewControllers = [
            makeGitHubSearchViewController(),
            makeGitHubProfileViewController()
        ]

        self.viewControllers = viewControllers.map { UINavigationController(rootViewController: $0) }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeGitHubSearchViewController() -> UIViewController {
        GitHubSearchViewController()
    }

    private func makeGitHubProfileViewController() -> UIViewController {
        let reactor = GitHubProfileReactor()
        return GitHubProfileViewController(reactor: reactor)
    }
}
